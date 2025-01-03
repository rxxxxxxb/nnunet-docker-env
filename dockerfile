# Use a base image with PyTorch and CUDA
FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-devel



ENV DEBIAN_FRONTEND=noninteractive

# Update system and install basic dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*





# Set up env
ENV nnUNet_raw="/workspace/nnUNet/nnUNet_raw"
ENV nnUNet_preprocessed="/workspace/nnUNet/nnUNet_preprocessed"
ENV nnUNet_results="/workspace/nnUNet/nnUNet_results"

# Set up working directory
WORKDIR /workspace

# Copy requirements.txt and install Python dependencies
COPY requirements.txt /workspace/
RUN pip install --upgrade pip && \
    pip install -r /workspace/requirements.txt && \
    pip cache purge

# Install PyTorch with CUDA
# RUN pip install torch==2.4.0 torchvision==0.19.0 torchaudio==2.4.0 --index-url https://download.pytorch.org/whl/cu124


# Create data directories
RUN mkdir -p $nnUNet_raw $nnUNet_preprocessed $nnUNet_results



# Set default command
CMD ["bash"]