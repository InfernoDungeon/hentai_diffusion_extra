import subprocess, os

installed_aria2 = False
init()


def init():
    global installed_aria2
    try:
        subprocess.run(["aria2c", "--quiet", "&>null"])
        print("aria2 installed!")
    except:
        print("aria2 not installed!")
        install_package("aria2")
        installed_aria2 = True

def install_package(package_name):
    subprocess.run("apt",  "install", package_name, "--yes")

def download_model(model_dictionary, models_patch):
    global installed_aria2
    if installed_aria2 == False:
        install_package("aria2")
    for model in model_dictionary:
        if os.path.isfile(models_patch + model) == False:
          print('!Downloading ' + lora_model)
          subprocess.run(["aria2c", model_dictionary[model], "--quiet", "--summary-interval=0", "-c", "-x 16", "-s16", "-k 1M", "-d", models_patch, "-o", model])
