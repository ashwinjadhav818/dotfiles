import asyncio
import json
import logging
import websockets

async def dwindle_layout(websocket, cancel_event):
    await websocket.send("sub -e window_managed")
    while not cancel_event.is_set():
        try:
            response = await asyncio.wait_for(websocket.recv(), timeout=1.0)
            json_response = json.loads(response)
            if json_response["messageType"] == "client_response":
                logging.debug(f"Event subscription: {json_response['success']}")
            elif json_response["messageType"] == "event_subscription":
                tiling_size = json_response['data']['managedWindow']['tilingSize']
                logging.debug(f"Tiling Size: {tiling_size}")
                if tiling_size is not None and tiling_size <= 0.5:
                    await websocket.send('c toggle-tiling-direction')
        except asyncio.TimeoutError:
            continue
        except Exception as e:
            logging.error(f"Dwindle script error: {e}")

async def run(cancel_event):
    uri = "ws://localhost:6123"
    try:
        async with websockets.connect(uri) as websocket:
            await dwindle_layout(websocket, cancel_event)
    except Exception as e:
        logging.error(f"Connection error: {e}")
