[
  {
    event = [
      "BufRead"
      "BufNewFile"
    ];
    pattern = [ "*.tf" ];
    command = "setfiletype tf";
  }

  {
    event = [ "InsertEnter" ];
    pattern = [ "*" ];
    command = "match EOLWS // | match EOLWSInsert /\\\\s\\\\+\\\\%#\\\\@<!$\\\\| \\\\+\\\\ze\\\\t/";
  }
  {
    event = [ "InsertLeave" ];
    pattern = [ "*" ];
    command = "match EOLWS // | match EOLWSInsert /\\\\s\\\\+\\\\%#\\\\@<!$\\\\| \\\\+\\\\ze\\\\t/";
  }
  {
    event = [
      "WinEnter"
      "BufWinEnter"
      "WinNew"
    ];
    pattern = [ "*" ];
    command = "match EOLWS /\\\\s\\\\+$\\\\| \\\\+\\\\ze\\t/";
  }
  {
    event = [ "WinEnter" ];
    pattern = [ "*" ];
    command = "set cul";
  }
  {
    event = [ "WinLeave" ];
    pattern = [ "*" ];
    command = "set nocul";
  }
  {
    event = [ "BufWritePre" ];
    pattern = [ "*.go" ];
    command = ":silent call CocAction('runCommand', 'editor.action.organizeImport')";
  }
  {
    event = [
      "BufRead"
      "BufNewFile"
    ];
    pattern = [
      "*.tf"
      "*.tfvars"
    ];
    command = "setfiletype terraform";
  }
]

