# **NNUNet Docker Training Environment**

This repository contains a Dockerized setup for training and inference with [NNUNet](https://github.com/MIC-DKFZ/nnUNet). 

---

## **Prerequisites**

1. **Hardware**: Ensure you have access to a NVIDIA GPU-enabled system with CUDA installed.
2. **Dependencies**: The Docker container installs all necessary dependencies, but you need the following on your host machine:
   - Docker
   - NVIDIA Container Toolkit for GPU support 
3. **Dataset Preparation**:
   - Place your dataset in the `nnunet/nnUNet_raw/` directory.
   - The folder structure should look like this:
     ```
     nnunet/
        ├── nnUNet_raw/
        │   └── Dataset501_GCA_single-label/
        │       ├── imagesTr/
        │       ├── labelsTr/
        │       └── imagesTs/
        ├── nnUNet_preprocessed/
        └── nnUNet_results/
     ```


## **Docker Setup Instructions :**

**Step 1: Build the Docker Image**
Build the Docker container:

`docker build -t nnunet:latest .`

**Step 2: Run the Docker Container**

`docker compose up -d`

**Step 3: Access the Docker Container**

`docker exec -it nnunet-container bash`

## **Usage :**


1. **Preprocessing :** 
Run the preprocessing command: 

`nnUNetv2_plan_and_preprocess -d {DATASET_ID} --verify_dataset_integrity`

2. **Visualize overlay PNGs to verify the input data:** 
Run the command: 

`nnUNetv2_plot_overlay_pngs -d {DATASET_ID} -o /workspace/nnUNet/nnUNet_raw/{DATASET_NAME}/imagesTr/overlay`



## **Training :**
Start the training process using the following command:

`nnunetv2_train {DATASET_ID} 3d_fullres 1` 

You can change the training configuration according to your need.  

## **Inference :**
To perform inference on test data, use the following command:

``` 
nnunetv2_predict -i /workspace/nnUNet/nnUNet_raw/Dataset501_GCA_single-label/imagesTs -o /workspace/nnUNet/predict -d 501 -c 3d_lowres -f 0
```

```
    -i: Input directory containing the test images.
    -o: Output directory for predictions.
    -d: Dataset ID (e.g., 501).
    -c: Configuration mode (e.g., 3d_lowres or 3d_fullres).
    -f: Fold ID (e.g., 0 for fold 0).
```

