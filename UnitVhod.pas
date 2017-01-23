unit UnitVhod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormVhod = class(TForm)
    LabelLogin: TLabel;
    LablePassword: TLabel;
    Login: TEdit;
    Password: TEdit;
    btnVhod: TButton;
    btnRegistr: TButton;
    procedure btnVhodClick(Sender: TObject);
    procedure btnRegistrClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormVhod: TFormVhod;

implementation

uses UnitMain, UnitReg, UnitAddEvent;

{$R *.dfm}

procedure TFormVhod.btnVhodClick(Sender: TObject);
var
    h:human;
    f:file of human;
    fe:file of Event;
begin
  if (Login.Text<>'Login') and (Password.Text<>'Login') then
    if FileExists(FormMain.dir+login.Text) then //проверка существования файла
    begin
      AssignFile(f,FormMain.dir+Login.Text);
      Reset(f);
      Seek(f,0);
      FormMain.count:=0;
      while not Eof(f) do
      begin
        read(f,h);
      end;
      closefile(f);
      if h.password=Password.Text then
      begin
        AssignFile(fe,FormMain.dir+h.name+'events');
        Reset(fe);
        Seek(fe,0);
        while not Eof(fe) do
        begin
          read(fe,formmain.ev[formmain.count]);
          Inc(FormMain.count);
        end;
      end;
      formmain.h:=h;
      FormMain.show;
      FormVhod.Hide;
    end
    else
      MessageDlg('Неверный логин или пароль',mtError, mbOKCancel, 0)
    else
      ShowMessage('Введите логин и пароль');
end;

procedure TFormVhod.btnRegistrClick(Sender: TObject);
begin
  formreg.show;
end;

procedure TFormVhod.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;
end.
