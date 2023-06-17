# scfg.txt
CA8271x SoC reads the configuration from the `default_scfg.txt` and `scfg.txt` files.

These files are usually found under `/config/` 
but, some sticks are dynamically generated according to their custom configuration area in ROM,
or are set to read-only, so you may need to edit `sfcg.txt`, which is stored in a different path.

To obtain scfg.txt for each ONT, see the following links.

- Link

## EN-XGSFPP-OMAC, XGS-ONU-25-20NI, FOX222 (XG-99x)
In the XG-99x series ONT, the settings are loaded by four scfg.txt files.
For rewriting settings, `/userdata/scfg.txt` and `/tmp/scfg.txt` are used.

- `/config/default_scfg.txt`  (ReadOnly) <br>
Contains the manufacturer's default settings,<br>
which are read first at ONT startup and are the lowest priority settings.<br>
- `/config/scfg.txt` (ReadOnly)<br>
Contains settings set by the firmware creator,<br>
which have higher priority than default_scfg.txt and will overwrite the settings if there is a conflict.<br>
Nothing entry in EN-XGSFPP-OMAC Stick.<br>
- `/userdata/scfg.txt` (RW)<br>
Contains settings set by the user or ISP.<br>
It has a higher priority than /config/scfg.txt and will overwritte the settings if there is a conflict.<br>
Can be edited and saved.<br>
- `/tmp/scfg.txt` (Can't Save)<br>
It contains dynamically generated settings based on values stored on its custom ROM (mtd9, mtd10)<br>
Since they are generated on tmpfs and cannot be saved directly,<br>
they are rewritten via the `#ONT> system/misc` command on the ONT.<br>

The settings are overwritten and loaded at startup with the following priority.

***(High)*** `/tmp/scfg.txt` > `/userdata/scfg.txt` > `/config/scfg.txt` > `/config/default_scfg.txt` ***(Low)***

## LTF-726x-BH+
In the LTF-726x-BH+ series ONT, the settings are loaded by two scfg.txt files.
For rewriting settings `/config/scfg.txt` are used.

- `/config/default_scfg.txt`  (RW)<br>
Contains the manufacturer's default settings,<br>
which are read first at ONT startup and are the lowest priority settings.<br>
They can be edited, but must not be rewritten.<br>
- `/config/scfg.txt` (RW)<br>
Contains settings set by the user or ISP.<br>
It has a higher priority than /config/scfg.txt and will overwritte the settings if there is a conflict.<br>
Can be edited and saved.<br>

The settings are overwritten and loaded at startup with the following priority.

***(High)***  `/config/scfg.txt` > `/config/default_scfg.txt` ***(Low)***
