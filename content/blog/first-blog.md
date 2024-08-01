+++
title = "First blog"
date = "2024-08-01T11:55:31+08:00"
description = "A test post."
tags = []
+++

Here's a random script I wrote for Blender's Audvis addon. This generates cool-looking visualizer bars:

```python
import bpy
import math


def delete_object_if_exists(name):
    if name in bpy.data.objects:
        bpy.data.objects.remove(bpy.data.objects[name], do_unlink=True)


def get_or_create_empty(name):
    if "Visualizer Root" in bpy.data.objects:
        return bpy.data.objects.get("Visualizer Root")

    root_empty = bpy.data.objects.new("Visualizer Root", None)
    bpy.context.collection.objects.link(root_empty)

    return root_empty


# https://en.wikipedia.org/wiki/Pitch_(music)#Labeling_pitches
def hz_to_pitch(hz):
    return 69 + 12 * math.log(hz / 440, 2)


# https://en.wikipedia.org/wiki/Pitch_(music)#Labeling_pitches
def pitch_to_hz(pitch):
    return 440 * math.exp((pitch - 69) * math.log(2) / 12)


def create_hz_ranges(count: int, hz_min: int, hz_max: int, pitch_overlap: float = 0.0, skip: int = 0):
    pitch_min = hz_to_pitch(hz_min)
    pitch_max = hz_to_pitch(hz_max)
    pitch_interval = (pitch_max - pitch_min) / count

    for i in range(count + skip):
        if i < skip:
            continue

        start = pitch_min + pitch_interval * i
        stop = pitch_min + pitch_interval * (i + 1)

        start -= pitch_overlap
        stop += pitch_overlap

        start_hz = pitch_to_hz(start)
        stop_hz = pitch_to_hz(stop)

        print(f"{i}: {(start_hz, stop_hz)}")

        yield start_hz, stop_hz


def create_visualizer_cubes(count, bar_ratio: float, hz_min, hz_max, pitch_overlap=0.0):
    if count > 100:
        raise NotImplementedError("not support over 100 because i need to clear cubes every time you run this script")

    root_empty = get_or_create_empty("Visualizer Root")

    white_material = bpy.data.materials.get("White")

    def generate_cube_name(i):
        return f"Visualizer Bar {i + 1}"

    total_width = 2
    bar_width = total_width / count * bar_ratio
    bar_interval = total_width / count

    # clear cubes up to 100 (in case you created more cubes in a previous run)
    for i in range(100):
        delete_object_if_exists(generate_cube_name(i))

    # create cubes
    for i, (start, stop) in enumerate(create_hz_ranges(count, hz_min, hz_max, pitch_overlap=pitch_overlap, skip=5)):
        cube_name = generate_cube_name(i)
        delete_object_if_exists(cube_name)

        cube = bpy.ops.mesh.primitive_cube_add(
            size=1,
            location=(bar_interval * i - 1, 0, 0),
            scale=(bar_width, 1.0, 1.0)
        )
        bpy.context.object.name = cube_name
        bpy.context.object.parent = root_empty
        bpy.context.object.data.materials.append(white_material)

        driver_expression = f"audvis({start}, {stop}) * {stop - start} / {1 + i * 0.04} / 1000 / 1.2"

        driver = bpy.context.object.driver_add("location", 2)
        driver.driver.type = 'SCRIPTED'
        driver.driver.expression = f"({driver_expression}) / 2"
        driver = bpy.context.object.driver_add("scale", 2)
        driver.driver.type = 'SCRIPTED'
        driver.driver.expression = driver_expression


COUNT = 64
BAR_WIDTH = 0.75
HZ_MIN = 20
HZ_MAX = 5000
#HZ_MAX = 250
OVERLAP = 1.0

create_visualizer_cubes(COUNT, BAR_WIDTH, HZ_MIN, HZ_MAX, pitch_overlap=OVERLAP)
```
