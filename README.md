# DriveInsight Dataset

**CCTV-based, simulation-ready traffic trajectories and scenarios for autonomous driving research**

---

## At a Glance

- **20+ urban intersections** across multiple countries and continents
- **Hundreds of hours** of 24/7 CCTV footage capturing authentic traffic behaviors
- **On the order of 120k car trajectories**, **55k pedestrian trajectories**, **34k bicycle trajectories**, plus thousands of trucks, buses, and motorcycles
- **OpenSCENARIO format** (.xosc) compatible with esmini, CARLA, VTD, and other industry-standard simulators
- **Rich annotations**: vehicle trajectories, road networks (OpenDRIVE), weather data, and temporal metadata
- **Simulation-ready scenarios** distilled from continuous city CCTV streams

---

## Overview

DriveInsight is a large-scale dataset that bridges the gap between real-world traffic observations and simulation-ready scenarios. The dataset extracts traffic scenarios from publicly available CCTV camera feeds and converts them into standardized OpenSCENARIO format, enabling researchers to leverage authentic traffic behaviors for autonomous vehicle development, validation, and testing.

DriveInsight scenarios are distilled from continuous 24/7 CCTV streams captured at urban intersections across multiple countries and continents. Each scenario includes precise vehicle trajectories, road network topology (OpenDRIVE), weather conditions, and temporal metadata, making it fully compatible with industry-standard simulation tools such as esmini, CARLA, and VTD.

The dataset is designed for a wide range of research applications, including trajectory forecasting (Trajectron++, AgentFormer, HiVT, PECNet, etc.), scenario-based validation of autonomous driving and ADAS systems, multi-agent interaction modeling, and long-tail behavior analysis.

---

## What This Repository Provides

This repository provides the **public DriveInsight distribution** along with scripts and utilities to:

- Load and visualize scenarios programmatically
- Run scenarios in simulators (e.g., esmini)
- Reproduce benchmark setups from the paper
- Parse OpenSCENARIO files and extract trajectory data
- Access scenario metadata and annotations

The repository includes scenarios from multiple intersections, organized by location, with corresponding OpenDRIVE road networks and 3D environment models. Each scenario is provided in OpenSCENARIO format with associated metadata files containing timestamps, geographic coordinates, weather conditions, and traffic annotations.

**Extended access**: Additional intersections, extended scenario collections, and high-resolution CCTV source footage can be requested via the project website.

---

## Project Website / Extended Access

**Project website**: [https://driveinsight.io](https://driveinsight.io) <!-- TODO (author): verify URL -->

Use the contact form on the project website to request extended access, collaborations, or commercial licensing.

---

## Repository Structure

```
driveinsightD/
├── database/
│   ├── <location_id>/
│   │   ├── {id}_scenario.xosc          # OpenSCENARIO scenario file
│   │   ├── {id}_scenario_metadata.json # Scenario metadata
│   │   ├── <location_id>.xodr          # OpenDRIVE road network
│   │   └── <location_id>.osgb          # 3D environment model
├── images/
│   ├── zlin_original.png               # Example CCTV frame
│   └── zlin_simulated.png              # Example simulation reconstruction
├── run_scenario.sh                     # Script to visualize scenarios
├── set_up.sh                          # Setup script for dependencies
└── README.md
```

### File Types

- **`.xosc`**: OpenSCENARIO XML files containing vehicle entities, trajectories, and scenario logic. Each file defines multiple agents (vehicles, pedestrians, cyclists) with precise trajectory waypoints and temporal information.

- **`*_metadata.json`**: JSON files with scenario annotations including:
  ```json
  {
    "camera_name": "cz_zlin",
    "datetime_utc": "2025-10-16T18:21:45+00:00",
    "location_name": "Zlin, Czech Republic",
    "road_description": {
      "road_name": "Tř. Tomáše Bati / Osvoboditelů",
      "road_type": "Urban Road",
      "road_condition": "Good",
      "traffic_density": "Moderate",
      "road coating": "Asphalt",
      "configuration": "crossing"
    },
    "weather": {
      "lat": 49.2256,
      "lon": 17.6687,
      "timezone": "Europe/Prague",
      "timezone_offset": 7200,
      "data": [/* weather conditions */]
    }
  }
  ```

- **`.xodr`**: OpenDRIVE road network definition files describing lane geometry, intersections, and road topology for each location.

- **`.osgb`**: OpenSceneGraph binary 3D environment models providing photorealistic scene geometry for visualization and simulation.

---

## Quick Start

### Clone the Repository

```bash
git clone https://github.com/[username]/driveinsightD.git  # TODO (author): update with actual repository URL
cd driveinsightD
```

### Set Up Simulation Environment

To visualize scenarios using esmini, set up the simulation environment:

```bash
chmod +x set_up.sh
./set_up.sh
```

This script downloads and extracts the esmini simulator (v2.35.0) and 3D environment models (`.osgb` files) for all locations.

### Visualize a Scenario

Run a scenario using the provided script:

```bash
./run_scenario.sh database/cz_zlin/106_scenario.xosc
```

The script automatically detects the location and applies appropriate camera parameters.

### Load and Parse Scenarios Programmatically

Here's a minimal Python example to load and inspect a DriveInsight scenario:

```python
import json
import xml.etree.ElementTree as ET
from pathlib import Path

# Path to a scenario
scenario_id = "106"
location = "cz_zlin"
base_path = Path("database") / location

# Load metadata
metadata_path = base_path / f"{scenario_id}_scenario_metadata.json"
with open(metadata_path, 'r') as f:
    metadata = json.load(f)

print(f"Location: {metadata['location_name']}")
print(f"Timestamp: {metadata['datetime_utc']}")
print(f"Traffic density: {metadata['road_description']['traffic_density']}")

# Parse OpenSCENARIO file
xosc_path = base_path / f"{scenario_id}_scenario.xosc"
tree = ET.parse(xosc_path)
root = tree.getroot()

# Extract vehicle entities (OpenSCENARIO namespace)
namespace = {'xosc': 'http://www.asam.net/xosc'}
entities = root.findall('.//xosc:ScenarioObject', namespace)

print(f"\nFound {len(entities)} agents:")
for entity in entities:
    agent_name = entity.get('name')
    # Extract trajectory waypoints
    trajectory = entity.findall('.//xosc:Vertex', namespace)
    print(f"  {agent_name}: {len(trajectory)} trajectory points")
```

---

## Dataset Statistics

DriveInsight provides comprehensive coverage of diverse traffic participants across more than twenty intersections in multiple cities and countries. The dataset includes trajectories for multiple agent types:

| Agent Type | Approximate Count |
|------------|-------------------|
| Cars | ~120,000 |
| Trucks | ~17,500 |
| Buses | ~2,700 |
| Pedestrians | ~55,000 |
| Bicycles | ~34,000 |
| Motorcycles | ~650 |

The following table compares DriveInsight with other major traffic datasets:

| Dataset | # Cars | # Trucks | # Buses | # Pedestrians | # Bicycles | # Motorcyclists |
|---------|--------|----------|---------|---------------|------------|-----------------|
| INTERACTION [12] | 39,834 | 117 | 79 | 1,541 | 456 | 3 |
| Stanford [14] | 316 | - | 76 | 5,232 | 4,210 | - |
| NGSIM [13] | 3,124 | 86 | - | - | - | 23 |
| highD [10] | 90,000 | 20,000 | - | - | - | - |
| rounD [11] | 69,399 | 2,123 | 932 | 1,819 | 1,583 | 261 |
| inD [9] | 7,876 | 345 | 12 | 3,107 | 2,259 | - |
| SinD [18] | 4,792 | 107 | 51 | 1,652 | 3,286 | 3,360 |
| **DriveInsight** | **~120,000** | **~17,500** | **~2,700** | **~55,000** | **~34,000** | **~650** |

DriveInsight stands out with the highest number of cars, pedestrians, and bicycles compared to other major datasets, providing rich diversity for multi-agent traffic research.

---

## Applications

DriveInsight scenarios are designed for various research and development applications:

### Trajectory Forecasting
Train and evaluate trajectory prediction models (Trajectron++, AgentFormer, HiVT, PECNet, etc.) using real-world multi-agent interactions with diverse traffic patterns across different regions.

### Scenario-Based Validation
Use authentic traffic scenarios for testing autonomous driving and ADAS systems, ensuring validation against realistic edge cases and common traffic behaviors.

### Multi-Agent Interaction Modeling
Study complex interaction dynamics, long-tail behaviors, and rare traffic events captured from continuous 24/7 CCTV streams.

### Traffic Analytics and Planning
Analyze traffic flow patterns, driver behaviors, and intersection dynamics across different geographic and cultural contexts.

### Simulation Benchmarking
Compare simulation frameworks and validate scenario generation methods against ground-truth real-world data.

---

## Citation

If you use this code or the DriveInsight dataset, please cite:

```bibtex
@article{zhdanov2025driveinsight,
  title={DriveInsight: CCTV-based dataset capturing real-world scenarios},
  author={Zhdanov, Pavlo and Yerumbayev, Sultan and Khan, Adil and Ram{\'i}rez Rivera, Ad{\'i}n},
  journal={IEEE Transactions on Circuits and Systems for Video Technology},
  year={2025},
  note={Under review}
}
```

**Plain text citation**:
> P. Zhdanov, S. Yerumbayev, A. Khan, and A. Ramírez Rivera, "DriveInsight: CCTV-based dataset capturing real-world scenarios," *IEEE Transactions on Circuits and Systems for Video Technology*, 2025 (under review).

---

## License

<!-- TODO (author): Add license information -->

---

## Contact

- **Project Website**: [https://driveinsight.io](https://driveinsight.io) <!-- TODO (author): verify URL -->
- **GitHub Repository**: [https://github.com/[username]/driveinsightD](https://github.com/[username]/driveinsightD) <!-- TODO (author): update with actual repository URL -->
- **Issues & Pull Requests**: Welcome via GitHub Issues and Pull Requests

For collaboration inquiries, extended dataset access, or commercial licensing, please use the contact form on the project website.

---

## Acknowledgements

We thank the following organizations and communities:

- The cities and municipalities providing public CCTV camera feeds
- The esmini development team for their excellent OpenSCENARIO simulation framework
- The OpenSCENARIO and OpenDRIVE standardization communities
- All contributors and users of the DriveInsight dataset

---

**DriveInsight Dataset** — Bridging real-world traffic observations with simulation-ready scenarios for autonomous driving research.
