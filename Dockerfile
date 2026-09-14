FROM runpod/worker-comfyui:5.10.0-base

# Network Volume se models load karo (Build ke doran download NAHI karo)
RUN rm -rf /comfyui/models && ln -s /runpod-volume/models/ltx-2.5 /comfyui/models

# user-provided inputs
RUN wget --progress=dot:giga -O '/comfyui/input/neon_cyborg_portrait.png' "https://..."
