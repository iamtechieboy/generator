Project used Clean Architecture design pattern.

## Features
Project is ready to modify and add new features.

‼️Attention:
  - Before running the project, add fonts you want to use in the project to the assets/fonts folder and update pubspec.yaml file.
  - As we are still working on this project, Swagger UI models might be generated wrongly, please check the actual swagger model

Here some other essential commands to help you:

- Generate CLA project =>
  \$ dart compile exe bin/main.dart -o bin/generator 
  \n after generating the executable file, make sure to add the path to the environment variable
  \n on macOS register path of generator file in shell profile e.g. ~/.zshrc or ~/.bash_profile
  \n on windows register path of generator file in environment variables check it out => https://phoenixnap.com/kb/windows-set-environment-variable

- Generate new project =>
  \$ generator project

- Generate new feature =>
  \$ generator feature

- Regenerate LocaleKeys =>
  \$ dart run easy_localization:generate -S "assets/translations" -O "lib/generated" & dart run easy_localization:generate -S "assets/translations" -O "lib/generated" -o "locale_keys.g.dart" -f keys

- Rebuild build files =>
  \$ flutter pub run build_runner build --delete-conflicting-outputs
