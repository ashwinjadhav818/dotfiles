#!/usr/bin/env python3

# MIT License
#
# Copyright (c) 2018-2023 Jonny Tyers
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from __future__ import annotations
from attrs import define
from cattrs import structure
from cattrs import unstructure
import colorama
import click
import os
import shlex
import shutil
import subprocess
import sys
import yaml
from typing import Any
from typing import Generator
from typing import Optional

def print_msg(*msg):
    print(colorama.Fore.YELLOW, *msg, colorama.Fore.RESET, file=sys.stderr)

def print_warning(*msg):
    print(colorama.Fore.RED, *msg, colorama.Fore.RESET, file=sys.stderr)


def expand(path):
    if path is None:
        return None

    if type(path) is list:
        return [os.path.expanduser(os.path.expandvars(x)) for x in path]

    elif type(path) is str:
        return " ".join(expand(path.split(" ")))

    else:
        return os.path.expanduser(os.path.expandvars(path))


xdg_runtime_dir = os.environ.get(
    "XDG_RUNTIME_DIR", expand(f"/run/user/{os.getuid()}")
)
xdg_config_home = os.environ.get("XDG_CONFIG_HOME", expand("$HOME/.config"))
xdg_cache_home = os.environ.get("XDG_CACHE_HOME", expand("$HOME/.cache"))
xdg_data_home = os.environ.get("XDG_DATA_HOME", expand("$HOME/.local/share"))

@define
class NoSuchProfileError(Exception):
    profile_name: str

@define
class ProfileAlreadyExistsError(Exception):
    profile_name: str

@define
class ConfigProfile:
    name: str
    args: list[str] = []

@define
class Config:
    profiles: list[ConfigProfile] = []

@define
class ConfigLoader:
    filename: str
    _cached_config: Optional[Config] = None

    def load(self) -> Config:
        if self._cached_config is None:
            if os.path.exists(self.filename):
                with open(self.filename, 'r') as f:
                    data = yaml.safe_load(f)
                    self._cached_config = structure(data, Config)
            else:
                self._cached_config = Config()

        return self._cached_config

    def get_or_create_profile(self, profile_name: str, args: list[str] = []) -> ConfigProfile:
        profile = self.get_profile(profile_name)
        if not profile:
            if not args:
                args = ['--set', 'window.title_format', f'{{perc}}{{title_sep}}{{current_title}} - qutebrowser [{profile_name}]']
            profile = ConfigProfile(name=profile_name, args=args)
            self.load().profiles.append(profile)
        return profile

    def get_profile(self, profile_name: str) -> Optional[ConfigProfile]:
        for profile in self.load().profiles:
            if profile.name == profile_name:
                return profile

        return None

    def delete_profile(self, profile_name: str) -> None:
        config = self.load()
        config.profiles = list(filter(lambda x: x.name != profile_name, config.profiles))

    def save(self, config: Optional[Config] = None):
        config_dir = os.path.dirname(self.filename)
        if not os.path.isdir(config_dir):
            os.makedirs(config_dir, exist_ok=True)

        data = unstructure(config or self.load())

        with open(self.filename, 'w') as f:
            yaml.dump(data, f)


@define
class QutebrowserProfile:
    parent: QutebrowserProfiles
    profile_name: str
    config: Optional[ConfigProfile]
    session: str = 'default'

    @property
    def basedir(self):
        return os.path.join(f"{self.parent.xdg_runtime_dir}/qutebrowser/{self.profile_name}")

    def _dirs_and_links(self):
        return dict(
            dirs=[
                self.basedir,
                f"{self.parent.xdg_cache_home}/qutebrowser/{self.profile_name}",
                f"{self.parent.xdg_data_home}/qutebrowser/{self.profile_name}",
                f"{self.basedir}/runtime",
            ],
            links=[
                (f"{self.parent.xdg_cache_home}/qutebrowser/{self.profile_name}", f"{self.basedir}/cache"),
                (f"{self.parent.xdg_data_home}/qutebrowser/{self.profile_name}", f"{self.basedir}/data"),
                (f"{self.parent.xdg_config_home}/qutebrowser", f"{self.basedir}/config"),
            ],
        )

    def mkbasedir(self):
        # https://github.com/ayekat/localdir/blob/35fa033fb1274807c907a4a83431d3a8222283f6/lib/dotfiles/wrappers/qutebrowser
        # https://wiki.archlinux.org/index.php/Qutebrowser#dwb-like_session_handling
        #
        # Wrapper around qutebrowser that makes sessions (-r, --restore SESSION) behave
        # like they used to in dwb.
        #
        # We do so by filtering out the -r/--restore option passed to qutebrowser and
        # using the argument to set up the following directory structure and symbolic
        # links:
        #
        # $XDG_RUNTIME_DIR/qutebrowser/$session/cache → $XDG_CACHE_HOME/qutebrowser/$session
        # $XDG_RUNTIME_DIR/qutebrowser/$session/data → $XDG_STATE_HOME/qutebrowser/$session
        # $XDG_RUNTIME_DIR/qutebrowser/$session/data/userscripts → $XDG_DATA_HOME/qutebrowser/userscripts
        # $XDG_RUNTIME_DIR/qutebrowser/$session/config → $XDG_CONFIG_HOME/qutebrowser
        # $XDG_RUNTIME_DIR/qutebrowser/$session/runtime (no symlink, regular directory)
        #
        # We then specify $XDG_RUNTIME_DIR/qutebrowser/$session as a --basedir, and the
        # files will end up in their intended locations (notice how the config directory
        # is the same for all sessions, as there is no point in keeping it separate).
        #
        # DISCLAIMER: The author of this script manages all his configuration files
        # manually, so this wrapper script has not been tested for the use case where
        # qutebrowser itself writes to these files (and more importantly, if multiple
        # such "sessions" simultaneously write to the same configuration file).
        #
        # YOU HAVE BEEN WARNED.
        #
        # Written by ayekat in an burst of nostalgy, on a mildly cold wednesday night in
        # February 2017.
        #
        # Enhanced a little by jonny on a dreary cold Friday morning in December 2018.
        #

        dirs_and_links = self._dirs_and_links()

        for d in dirs_and_links['dirs']:
            os.makedirs(d, exist_ok=True)

        for src, dst in dirs_and_links['links']:
            if os.path.exists(dst):
                os.unlink(dst)
            os.symlink(src, dst, target_is_directory=False)

    def remove(self):
        # Delete the profile's directories and all associated links from the filesystem
        dirs_and_links = self._dirs_and_links()

        # do links first, as some (or all) of them will reside in basedir, which is one of the dirs
        for src, dst in dirs_and_links['links']:
            if os.path.exists(dst):
                if not os.path.islink(dst):
                    print_warning(f'warning: did not remove {dst} as it is not a symlink')

                else:
                    print_msg(f'removing {dst}')
                    os.unlink(dst)

        for d in dirs_and_links['dirs']:
            if os.path.exists(d):
                if not os.path.isdir(d):
                    print_warning(f'warning: did not remove {d} as it is not a directory')
                else:
                    print_msg(f'removing {d}')
                    shutil.rmtree(d, ignore_errors=True)

        self.parent.config_loader.delete_profile(self.profile_name)


@define
class QutebrowserProfiles:
    profiles_root: str

    config_loader: ConfigLoader

    xdg_runtime_dir: str
    xdg_cache_home: str
    xdg_data_home: str
    xdg_config_home: str

    _profiles: Optional[list[QutebrowserProfile]] = None

    def _populate_profiles(self) -> list[QutebrowserProfile]:
        """Populates _profiles if needed, then returns them."""
        if self._profiles is None:
            self._profiles = []
            for item in os.listdir(self.profiles_root):
                if self._exists(item):
                    config = self.config_loader.get_profile(item)
                    self._profiles.append(QutebrowserProfile(parent=self, profile_name=item, config=config))

        return self._profiles

    def profiles(self) -> list[QutebrowserProfile]:
        return list(self._populate_profiles())  # new list to prevent external changes

    def get_profile(self, profile_name: str) -> QutebrowserProfile:
        for profile in self._populate_profiles():
            if profile.profile_name == profile_name:
                return profile

        raise NoSuchProfileError(profile_name)

    def _exists(self, profile_name):
        """Checks if a profile with the given name exists under profiles_root. Looks at the filesystem
        and not at the _profiles cache."""
        item_path = os.path.join(self.profiles_root, profile_name)

        # our profilesRoot may contain dirs that are not qutebrowser profiles, so we look for
        # the 'state' file to determine whether something is a profile, and then pipe thru dirname
        # find "$profilesRoot" -mindepth 2 -maxdepth 2 -name state -type f -printf "%P\n" | xargs dirname
        return os.path.isdir(item_path) and os.path.exists(os.path.join(item_path, 'state'))

    def new(self, profile_name, qb_args: list[str] = []) -> QutebrowserProfile:
        """Creates a new QutebrowserProfile as part of this QutebrowserProfiles instance, including
        its profile dirs."""
        if self._exists(profile_name):
            raise ProfileAlreadyExistsError(profile_name)

        # route via get_or_create_profile so that a) we pick up any user-defined config and b) profile creation
        # is centralised in one place
        config = self.config_loader.get_or_create_profile(profile_name, args=qb_args)

        result = QutebrowserProfile(parent=self, profile_name=profile_name, config=config)
        self._populate_profiles().append(result)
        result.mkbasedir()

        return result


    def run_qb(self, qutebrowser: str, profile: QutebrowserProfile, args: list[Optional[str]] = None, show_stdio: bool = False):
        """Run qutebrowser, loading the given profile.

        Args:
          qutebrowser - path to qutebrowser entrypoint
          profile - profile to load
          args - arguments to pass to qutebrowser beyond those to set the profile path (replaces any args specified in the profile's config)
          show_stdio - pass through stdout/stderr from qutebrowser
        """
        if not isinstance(profile, QutebrowserProfile):
            raise ValueError(f'profile must be a QutebrowserProfile, not {type(profile)}')

        # Set up session base directory, unless --basedir has been specified by the
        # user:
        profile.mkbasedir()

        args_ = [ qutebrowser, '--basedir', profile.basedir ]

        if args:
            args_.extend(filter(lambda x: x is not None, args))
        elif profile.config and profile.config.args:
            args_.extend(filter(lambda x: x is not None, profile.config.args))

        # Translate options: remove occurrences of -r/--restore/-R/--override-restore
        for idx, arg in enumerate(args_):
            if arg is None:
                continue
            if arg in ['--restore', '-r' ]:
                args_[idx] = None
                args_[idx+1] = None  # following arg would be session_name
            if arg in ['--override-restore', '-R' ]:
                args_[idx] = None

        stdin = None
        stderr = None
        stdout = None

        if not show_stdio:
            stdin = subprocess.DEVNULL
            stderr = subprocess.DEVNULL
            stdout = subprocess.DEVNULL

        p = subprocess.Popen(args_, stdin=stdin, stdout=stdout, stderr=stderr)
        print_msg(f'started process {p.pid}')


@click.command(context_settings=dict(
    ignore_unknown_options=True,
    help_option_names=['-h', '--help'],
))
@click.option(
    "--profiles-root",
    default=expand(f"{xdg_data_home}/qutebrowser"),  # "/run/user/$uid/qutebrowser"
    show_default=True,
    help="The directory to store profiles in",
)
@click.option(
    "--choose",
    default=False,
    is_flag=True,
    help="Prompt the user to choose a profile, then launch it",
)
@click.option(
    "--load",
    default=None,
    help="Load the given profile (fails if profile does not exist, see --new)",
)
@click.option(
    "--remove",
    default=None,
    help="Delete the given profile (including cache, cookies, history, site data etc) from the filesystem",
)
@click.option(
    "--new/--no-new",
    default=False,
    show_default=True,
    help="Allow --load to create a new profile if it does not exist",
)
@click.option(
    "--dmenu",
    required=False,
    help="Override the location of dmenu/rofi when using --choose",
)
@click.option(
    "--only-existing/--no-only-existing",
    default=False,
    help="Do not allow the user to specify a new (non-existent) profile during --choose",
)
@click.option(
    "--list-profiles", "--list", '-l',
    default=False,
    is_flag=True,
    help="List existing profiles",
)
@click.option(
    "--show-stdio",
    default=False,
    is_flag=True,
    show_default=True,
    help="Show stdout/stderr from qutebrowser when it is launched",
)
@click.option(
    "--qutebrowser",
    default=shutil.which("qutebrowser"),
    show_default=True,
    help="Location of qutebrowser launcher",
)
@click.option(
    "--config-file",
    default=expand('~/.config/qutebrowser-profile.yaml'),
    show_default=True,
    help="Location of profiles config file",
)
# eat up remaining args to pass to qutebrowser
@click.argument('qb_args', nargs=-1, type=click.UNPROCESSED)
def main(
    profiles_root: str,
    choose: bool,
    load: Optional[str],
    remove: Optional[str],
    new: bool,
    dmenu: Optional[str],
    only_existing: bool,
    list_profiles: bool,
    qutebrowser: str,
    qb_args: tuple[str],
    show_stdio: bool,
    config_file: str,
):
    # Set default values as defined in XDG base directory spec
    # https://specifications.freedesktop.org/basedir-spec/latest/

    config_loader = ConfigLoader(filename=config_file)

    qp = QutebrowserProfiles(
        profiles_root=profiles_root,
        config_loader=config_loader,
        xdg_runtime_dir = xdg_runtime_dir,
        xdg_config_home = xdg_config_home,
        xdg_cache_home = xdg_cache_home,
        xdg_data_home = xdg_data_home,
    )

    def _update_config_profile_with_qbargs(profile_name: str) -> ConfigProfile:
        profile = config_loader.get_or_create_profile(profile_name)

        if qb_args:
            profile.args = list(qb_args)

        return profile

    # as we're using arguments to simulate commands, we have to manually enforce that
    # some commands aren't specified together
    @define
    class MutuallyExclusiveCommands:
        mutually_exclusive: list[tuple[str, Optional[Any]]]

        def check_if_any_mutually_exclusive(self, except_keys: list[str] = []) -> bool:
            # check if any args specified in 'mutually_exclusive' are set, except for any
            # specified under 'except_keys' (which should be arg strings, such as ['--load'])
            for k, v in self.mutually_exclusive:
                if k in except_keys:
                    continue
                if v:
                    return True

            return False

        def raise_if_any_mutually_exclusive(self, except_keys: list[str] = []):
            if self.check_if_any_mutually_exclusive(except_keys):
                raise click.BadParameter(f'cannot use {", ".join(map(lambda me: me[0], self.mutually_exclusive))} together')

    mutually_exclusive = MutuallyExclusiveCommands([
            ('--load', load),
            ('--choose', choose),
            ('--list', list_profiles),
            ('--remove', remove),
        ])

    if not mutually_exclusive.check_if_any_mutually_exclusive():
        choose = True

    if list_profiles:
        mutually_exclusive.raise_if_any_mutually_exclusive(except_keys=['--list'])

        profiles = qp.profiles()
        for profile in profiles:
            print(profile.profile_name)

    if choose:
        mutually_exclusive.raise_if_any_mutually_exclusive(except_keys=['--choose'])

        profiles = qp.profiles()

        if not dmenu:
            rofi = shutil.which("rofi")
            if rofi:
                dmenu = f"{rofi} -dmenu"

            dmenu = shutil.which("dmenu")

        if not dmenu:
            # use terminal selection
            for idx, profile in enumerate(profiles):
                print(f'{idx+1}. {profile.profile_name}')

            print('')
            print('Choose a number or name: ')
            ans = input()

            try:
                idx = int(ans)
                profile = profiles[idx-1]

            except ValueError: # ans wasn't a number
                profile = qp.get_profile(ans)

        else:

            dmenuArgs = shlex.split(dmenu) + ["-p", "qutebrowser"]

            if only_existing:
                dmenuArgs.append("-no-custom")

            p = subprocess.Popen(dmenuArgs,
                                     stdin=subprocess.PIPE,
                                     stderr=subprocess.PIPE,
                                     stdout=subprocess.PIPE)

            choice_lines = '\n'.join(map(lambda px: px.profile_name, profiles))
            choice, errors = p.communicate(choice_lines.encode('utf-8'))

            if p.returncode not in [0, 1] or (p.returncode == 1 and len(errors) != 0):
                raise ValueError(
                    "{} returned {} and error:\n{}"
                    .format(dmenuArgs, p.returncode, errors.decode('utf-8'))
                )

            profile_name = choice.decode('utf-8').rstrip()

            try:
                profile = qp.get_profile(profile_name)

            except NoSuchProfileError:
                if not new:
                    raise

                profile = qp.new(profile_name, qb_args=list(qb_args))

        profile.config = _update_config_profile_with_qbargs(profile_name=profile.profile_name)
        qp.run_qb(qutebrowser=qutebrowser, profile=profile, args=list(qb_args), show_stdio=show_stdio,)

    if load:
        mutually_exclusive.raise_if_any_mutually_exclusive(except_keys=['--load'])

        try:
            profile = qp.get_profile(load)

        except NoSuchProfileError:
            if not new:
                raise

            profile = qp.new(load, qb_args=list(qb_args))

        profile.config = _update_config_profile_with_qbargs(profile_name=load)
        qp.run_qb(qutebrowser=qutebrowser, profile=profile, args=list(qb_args), show_stdio=show_stdio)

    if remove:
        mutually_exclusive.raise_if_any_mutually_exclusive(except_keys=['--remove'])

        profile = qp.get_profile(remove)
        profile.remove()  # remove() also deletes profile from config_loader


    # save the config (update-config logic happens in other args blocks above)
    try:
        config_loader.save()
        print_msg(f'saved config to {config_loader.filename}')

    except Exception as e:
        print_warning(f'could not save {config_loader.filename}: {str(e)}')
        # continue

if __name__ == '__main__':
    main()
