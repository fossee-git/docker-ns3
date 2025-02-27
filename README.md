# Build Instructions

## Using the Prebuilt Docker Image

You can directly use the prebuilt ns-3 Docker image without building it manually:

```sh
docker run --rm -it --shm-size=512m -p 6901:6901 -e VNC_PW=password -d ghcr.io/fossee-git/docker-ns3:latest
```

Then, open a browser and go to:
```sh
https://localhost:6901
```

Login credentials:
- **Username:** `kasm_user`
- **Password:** `password`

## Building the ns-3 Docker Image
Follow these steps to create a Docker image for ns-3 on your system:

1. Clone the following GitHub repository:
   ```sh
   git clone https://github.com/fossee-git/docker-ns3.git
   cd docker-ns3
   ```

2. Build the Docker image:
   ```sh
   docker build -t ns3:latest .
   ```
   > **Note:** The period (`.`) at the end refers to the current directory. The build process may take several minutes.

## Running the ns-3 Docker Image

1. Run the container with the following command:
   ```sh
   docker run --rm -it --shm-size=512m -p 6901:6901 -e VNC_PW=password -d ns3:latest
   ```

2. Open a browser and go to:
   ```
   https://localhost:6901
   ```
   If you see a security warning, click **Proceed** under Advanced options. If the site fails to connect, try a different browser.

3. Sign in using the following credentials:
   - **Username:** `kasm_user`
   - **Password:** `password`

4. The Linux desktop will open. Click on **Applications** in the top bar and open **Terminal Emulator**.

5. Navigate to the ns-3 installation directory:
   ```sh
   cd /home/kasm-default-profile/ns-allinone-3.38/ns-3.38/
   ```

## Running ns-3 Scripts

1. Get the ID of the running ns-3 Docker container:
   ```sh
   docker ps
   ```

2. Open a terminal on the host system and navigate to the directory where the ns-3 script is stored.

3. Copy the script to the running Docker container:
   ```sh
   docker cp {file_name} {container_id}:/home/kasm-default-profile/ns-allinone-3.38/ns-3.38/scratch
   ```

4. In the container's terminal, run the copied script:
   ```sh
   ./ns3 run scratch/{file_name}
   ```
   > Make sure you are in the ns-3 directory before running the command.

## Running NetAnim

1. Open **Terminal Emulator** in the Linux desktop.
2. Navigate to the NetAnim directory:
   ```sh
   cd /home/kasm-default-profile/ns-allinone-3.38/netanim/
   ```
3. Run NetAnim:
   ```sh
   ./NetAnim
   ```
   The NetAnim window will open.

## Stopping The Container
To stop the ns-3 Docker container, run:
```sh
   docker stop {container_id}
```

## Repository
GitHub Repository: [fossee-git/docker-ns3](https://github.com/fossee-git/docker-ns3)
