{ age, config, ... }: {
  age.secrets.todoist_config = {
    file = ../../files/configs/todoist/config.json.age;
    path = "${config.home.homeDirectory}/.config/todoist/config.json";
    mode = "600";
  };
}
