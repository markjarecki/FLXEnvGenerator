# FLXEnvGenerator

## About

FLXEnvGenerator installs the `envgenerator` Swift command-line tool into `/usr/local/bin`.

`envgenerator` generates an Environment Swift file containing an enum of environments, a `let` environment constant that describes the current environment, and a settings file for importing into your configuration files, from a YAML specification input file.

The tool can be used in the Terminal, a Makefile, or during `External Build Tool Configuration (EBTC)` execution. 


### Required environment specification file - `envspec.yml`

The tool reads the `environments` and `settings` described in an YAML file. By default, a file named `envspec.yml` is looked for in the current directory.

A typical `envspec.yml` file, for example, looks like:

```
environments:
    - development
    - testflight
    - appstore
settings:
    shared:
        - CODE_SIGN_ENTITLEMENTS: app.entitlements
    development:
        - PRODUCT_NAME: EnvsDV
        - STORYBOARD_NAME: LaunchScreen-development
    testflight:
        - PRODUCT_NAME: EnvsTF
        - STORYBOARD_NAME: LaunchScreen-testflight
    appstore:
        - PRODUCT_NAME: Envs
        - STORYBOARD_NAME: LaunchScreen-appstore

```

`environments` sets the available environments.

`settings` are optional. A `envgenerator.settings` file is always generated, but will contain no values, if none are specified.

There is a `shared` settings option, for settings that are used across all environments.

The other `settings` keys correspond to available `environments`. 

### Generated environment Swift file - `Environment.swift`

By default, a file named `Environment.swift` is generated.

It contains an enum (default: `Environment`) containing all environments defined in the `envspec.yml`.

It also contains an environment constant (default: `environment`) that is set to the current environment. This is set by `envgenerator`'s current environment flag `-e|--currentenvironment`.

A typical generated`Environment.swift` file, contains:

```
public enum Environment {

    case development
    case testflight
    case appstore

}

public let environment: Environment = .development 
```

### Generated Environment settings file - `envgenerator.settings`

By default, a file named `envgenerator.settings` is generated.

This can be included in `.xcconfig` files, or referenced in project configuration files.

It is particularly useful when combined with [XCodeGen](https://github.com/yonaskolb/XcodeGen) for programmatically generating projects and environments.

A typical generated `envgenerator.settings` file, if using the `development` environment in the example `envspec.yml`, contains:

```
CODE_SIGN_ENTITLEMENTS = app.entitlements
PRODUCT_NAME = EnvsDV
STORYBOARD_NAME = LaunchScreen-development
```

## Make usage

### Requirements

Building FLXEnvGenerator requires Swift 5.x toolchain with the Swift Package Manager.

Check you are running a compatible Swift environment: 


```
swift --version
```

### Install

Clone and navigate to project directory

```
git clone https://github.com/markjarecki/FLXEnvGenerator.git
cd FLXEnvGenerator
```

Installs `envgenerator` at `/usr/local/bin`

```
make install
```


### Uninstall

Removes `envgenerator` from `/usr/local/bin`

```
make uninstall
```


### Clean

Cleans up build directory

```
make clean
```


### Test

Run the tests
```
make test
```


## Usage:

### Invoke with options:

```
envgenerator [-e|--currentenvironment]
             [-s|--specpath] 
             [-S|--specname] 
             [-t|--settingspath] 
             [-T|--settingsname] 
             [-v|--environmentpath] 
             [-V|--environmentname] 
             [-o|--optionsname] 
             [-c|--constantname] 
             [-a|--access]
```

Options: 

- `-e|--currentenvironment`: **REQUIRED**. Name of current selected environment - must be an environment specified in the YAML environment spec file

- `-s|--specpath`: Path to YAML environment spec file - default: Current directory

- `-S|--specname`: Name of YAML environment spec file - default: "envspec.yml"

- `-t|--settingspath`: Path to generated environment build settings file - default: Current directory

- `-T|--settingsname`: Name of generated environment build settings file - default: "envgenerator.settings"
	
- `-v|--environmentpath`: Path to generated environment file - containing environment options enum and the current environment constant - default: Current directory

- `-V|--environmentname`: Name of generated environment file - containing environment options enum and the current environment constant - default: "Environment.swift"

- `-o|--optionsname`: Name of the generated enum environment options - default: "Environment"

- `-c|--constantname`: Name of the generated `let` environment constant - default: "environment"

- `-a|--access`: Generated environment types access modifier - public, internal, fileprivate - default: "public"


## Example usage

### Default:

In Terminal:
```
envgenerator [-e|--currentenvironment] development 
```

This will look for `envspec.yml` in the current directory and output files `Environment.swift` and `envgenerator.settings` in the current directory. 

It generates the files using `development` as the current environment. 


### Full overrides:

In Terminal:

```
envgenerator [-e|--currentenvironment] development
             [-s|--specpath] Specs/
             [-S|--specname] myspec.yml
             [-t|--settingspath] Settings/
             [-T|--settingsname] mysettings.settings
             [-v|--environmentpath] Environment/
             [-V|--environmentname] AppEnvironment
             [-o|--optionsname] MyAppEnvironment
             [-c|--constantname] theEnvironment
             [-a|--access] internal
```

This will look for `myspec.yml` in the `Specs/` directory, and output files `AppEnvironment.swift` in the `Environment/` directory, and `mysettings.settings` in the `Settings/` directory. 

It  generates the files using `development` as the current environment. 

It generates an `AppEnvironment.swift` file containing:
```
public enum MyAppEnvironment {

    case development
    case testflight
    case appstore

}

internal let theEnvironment: MyAppEnvironment = .development 
```

