# emulate CIG ONT in QEMU

GPON CIG ONT runs on the `MIPS-I v1` architecture and can be emulated by QEMU to run binaries.
This allows the user to generate a login password for CIG ONT.

(For some reason the binary for CORTINA SoC XGS ONT crashes QEMU and cannot be made to work.
However, the password generation logic is common to GPON CIG ONT, so it can be substituted! )

The GponCLI binaries available on this page were extracted from FOG421.

1. Install QEMU in Ubuntu 22.04.2
Install MIPS QEMU on Ubuntu with the following command.
```
sudo apt-get install qemu-user
```

2. download and extract `GponCLI.tar.gz`
[Download GponCLI.tar.gz from here](emulate_CIG/GponCLI.tar.gz) and extract it to any location.
```
wget https://github.com/YuukiJapanTech/CA8271x/blob/main/emulate_CIG/GponCLI.tar.gz
sudo tar -xvcf GponCLI.tar.gz -C /emulate_CIG
```


3. run `GponCLI` binary
Execute `GponCLI` by specifying rootfs with `chroot`.
```
ROOT=/emulate_CIG/root
sudo chroot $ROOT /bin/GponCLI
```

4. `GponCLI` starts and the CIG ONT CLI is displayed.
```
ONT> enable
#ONT>
```
