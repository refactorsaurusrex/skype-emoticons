$ErrorActionPreference = 'Stop'

$index = '<!DOCTYPE html>
<html>
  <head>
    <title>Skype Emoticons</title>
  </head>
  <style>
    img {
      cursor: pointer;
    }
    .flasher {
      animation: flash 0.25s 5;
    }
    .box {
      background: gray;
      width: 40px;
      height: 40px;
      display: inline-block;
      margin: 5px;
    }
    @keyframes flash {
      0%   { opacity: 0; }
      100% { opacity: 1; }
    }
  </style>
  <script>
    function CopyPath(fileName, id) {
      navigator.clipboard.writeText(fileName);
      var e = document.getElementById(id);
      e.classList.remove("flasher");
      setTimeout(function(){e.classList.add("flasher");}, 100)
    }
  </script>
  <body>
'

$files = Get-ChildItem -Path $PSScriptRoot -Filter "*.gif" | Select-Object -ExpandProperty FullName

foreach ($file in $files) {
  $name = Split-Path $file -Leaf
  $escapedPath = $file.Replace('\', '\\')
  $img = "    <div class='box'><img id='$name' src='$name' onclick=`"CopyPath('$escapedPath', '$name')`"></div>`r`n"
  $index += $img
}

$index += '  </body>
</html>'

Set-Content -Value $index -Path "$PSScriptRoot\index.html"