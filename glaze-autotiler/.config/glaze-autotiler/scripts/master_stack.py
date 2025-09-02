import asyncio
import json
import logging
import websockets

async def master_stack_layout(websocket, cancel_event):
    await websocket.send("sub -e window_managed")
    await websocket.send("sub -e focus_changed")
    while not cancel_event.is_set():
        try:
            response = await asyncio.wait_for(websocket.recv(), timeout=1.0)
            json_response = json.loads(response)
            if json_response["messageType"] == "client_response":
                logging.debug(f"Event subscription: {json_response['success']}")
            elif json_response["messageType"] == "event_subscription":
                window_data = (
                    json_response['data'].get('managedWindow') or
                    json_response['data'].get('focusedContainer')
                )
                if not window_data:
                    continue

                tiling_size = window_data.get('tilingSize')
                await websocket.send("query tiling-direction")
                direction_response = await websocket.recv()
                direction_json = json.loads(direction_response)
                current_direction = direction_json.get('data', {}).get('tilingDirection')

                if tiling_size is not None:
                    if tiling_size > 0.5 and current_direction != "horizontal":
                        await websocket.send('c set-tiling-direction horizontal')
                    elif tiling_size <= 0.5 and current_direction != "vertical":
                        await websocket.send('c set-tiling-direction vertical')
        except asyncio.TimeoutError:
            continue
        except Exception as e:
            logging.error(f"Master stack script error: {e}")

async def run(cancel_event):
    uri = "ws://localhost:6123"
    try:
        async with websockets.connect(uri) as websocket:
            await master_stack_layout(websocket, cancel_event)
    except Exception as e:
        logging.error(f"Connection error: {e}")
