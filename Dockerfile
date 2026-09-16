FROM runpod/worker-comfyui:5.10.0-base

# Network Volume se models load karo
RUN rm -rf /comfyui/models && ln -s /runpod-volume/models/ltx-2.5 /comfyui/models

# LTX-2.5 custom nodes install karo (YEH LINE ZAROORI HAI)
RUN comfy-node-install comfyui-ltxvideo

# user-provided inputs
RUN wget --progress=dot:giga -O '/comfyui/input/neon_cyborg_portrait.png' "https://cool-anteater-319.convex.cloud/api/storage/c1893727-9cbc-4255-8776-e4d5a30b8e36"
