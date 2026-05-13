# karniz-template-notes v0.0.2
karniz, template, delphi, pas, notes, html ,windeco

Редактор html-кода для создания примечаний компонентам шаблона карнизов

## Описание
В редактор передается две строки html и media. Первая содержит html код описания. media - коллекция используемых медиаданных ( рисунки, видео, файлы), которые будут использоваться в html.
 
## Использование.
1. Копируем содержимое папки KTN в свой проект
2. Поключаем к проекту
3. Запуск редактора

```pas
unit UMain;
...
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, KTN_EditorForm;

type
  TMyProject = class(TForm)
    procedure doit();
  private
    { Private declarations }
  public
    { Public declarations }
    media:string;
    html:string;
  end;


...

procedure TMyProject.doit();
begin
    if (KTN_EditorForm.KTNExecute(html,media)) then begin
        // html and media is already modified !!!!
    end
 end;


```