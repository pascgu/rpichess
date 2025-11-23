# install rPi

- use Raspberry Pi Imager to install **"Rasberry Pi OS (Legacy, 64-bit) Lite"** :

A port of Debian Bookworm with no desktop environment

[2025-10-01-raspios-bookworm-arm64-lite.img.xz](https://www.raspberrypi.com/software/operating-systems/)

Attention à bien mettre **Bookworm** pour avoir python 3.11

- configure ssh
- configure wifi (once ssh, use `sudo raspi-config`)

## install outils de base

`sudo apt update && sudo apt upgrade -y`

`sudo apt install -y git curl wget build-essential cmake python3 python3-pip`

`python --version` doit afficher 3.11.2

## install X11 for videoproj

`sudo apt install --no-install-recommends xserver-xorg xinit x11-xserver-utils`

```
touch ~/.Xauthority
chmod 600 ~/.Xauthority
sudo apt install xterm twm xfonts-base xfonts-75dpi xfonts-100dpi
echo "exec twm" > ~/.xinitrc
```

Ajoute config TWM. Doc : 2ème bouton pour quitter

```
cp /etc/X11/twm/system.twmrc ~/.twmrc
echo "LeftTitleButton \"target\" = f.delete" >> ~/.twmrc
echo "Button3 = : title : f.menu \"windowops\"" >> ~/.twmrc
echo "\"t\" = control : root : f.exec \"xterm &\"" >> ~/.twmrc
echo "\"x\" = control : root : f.quit" >> ~/.twmrc
```

Pour lancer X11 manuellement : `startx`

Pour activer le démarrage automatique en mode graphique : `sudo raspi-config`

 -> System Options > Boot / Auto Login > Desktop Autologin.

### export display si dev depuis autre PC [TODO : à tester/finir...]

Download and install le server X11 pour Windows : https://github.com/marchaesen/vcxsrv/releases/

`sudo apt install x11-apps` : optionnel, juste pour valider avec xclock par exemple

`export DISPLAY=192.168.1.24:0.0`

`startx`

`xclock`

##  Installer TensorFlow Lite (Pour l’IA)

Pour exécuter des modèles TFLite sur ton Raspberry Pi :

```
# Installer TensorFlow Lite pour Python
pip3 install tflite-runtime==2.14.0 numpy==1.26.4 --extra-index-url https://google-coral.github.io/py-repo/ --break-system-packages

# Tester l'installation (v2.14)
python3 -c "from tflite_runtime.interpreter import Interpreter; from tflite_runtime import __version__; print('TFLite installé avec succès :',__version__)"
```

### Exemple d’inférence :

```
# tester un modèle
wget http://download.tensorflow.org/models/mobilenet_v1_2018_08_02/mobilenet_v1_1.0_224_quant.tgz && \
tar -xvf mobilenet_v1_1.0_224_quant.tgz
rm mobilenet_v1_1.0_224_quant.tgz mobilenet_v1_1.0_224_quant.ckpt.* mobilenet_v1_1.0_224_quant_*

echo "
import numpy as n
from tflite_runtime.interpreter import Interpreter
from tflite_runtime import __version__ as tfv
import platform

try:
    py_v = platform.python_version()
    np_v = n.__version__

    m = 'mobilenet_v1_1.0_224_quant.tflite'
    i = Interpreter(model_path=m)
    i.allocate_tensors()
    
    d = i.get_input_details()[0]
    i.set_tensor(d['index'], n.zeros(d['shape'], dtype=d['dtype']))
    i.invoke()

    print(f'SUCCES : Inference reussie')
    print(f'Python Version : {py_v}')
    print(f'TFLite-Runtime : {tfv}')
    print(f'NumPy Version : {np_v}')
    print(f'Modele : {m}')
except Exception as e:
    print(f'ERREUR : {e}')
" > test_infer.py
python test_infer.py
```

## Configurer la PiCamera

Active la caméra Raspberry Pi (si tu utilises un module officiel) :

`sudo raspi-config`

Va dans Interfacing Options > Camera et active-la.

### Tester la caméra :

```
raspistill -o test.jpg  # Pour une photo
raspivid -o test.h264 -t 10000  # Pour une vidéo de 10 secondes
```

## Installer OpenCV (Pour le Prétraitement d’Images)

Si tu utilises une caméra pour détecter les pièces d’échecs :

```
sudo apt install -y python3-opencv
pip3 install opencv-python
```

### Tester OpenCV :

```
import cv2
cap = cv2.VideoCapture(0)
ret, frame = cap.read()
cv2.imwrite("test.jpg", frame)
print("Image capturée !")
```

## Install Godot [TODO: upgrade to 4.5.x]

Godot avec Interface Graphique

Si tu veux utiliser l’éditeur Godot avec une interface, installe la version ARM64 avec X11 :

wget https://downloads.tuxfamily.org/godotengine/4.0/Godot_v4.0-stable_linux.arm64.zip
unzip Godot_v4.0-stable_linux.arm64.zip

Lancer Godot :

startx ./Godot_v4.0-stable_linux.arm64

## Optimiser les perfs

Overclocking (Optionnel) :

Pour gagner en performance (attention à la surchauffe) :

`sudo raspi-config`

→ Performance Options > Overclock → Choisis un profil modéré (ex: CPU 1.8 GHz).
