unit UnitAddEvent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask;


type
  TFormAddEvent = class(TForm)
    lblName: TLabel;
    edtcutName: TEdit;
    lbldata: TLabel;
    dtpDateEvent: TDateTimePicker;
    lblTime: TLabel;
    lblopisanie: TLabel;
    MemoOpisanie: TMemo;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    edtStartEventTime: TMaskEdit;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  FormAddEvent: TFormAddEvent;

implementation

uses UnitMain;

{$R *.dfm}

procedure TFormAddEvent.ButtonOKClick(Sender: TObject);
var
  f: file of Event;
  i: integer;
begin
  if (edtcutName.Text<>'') and //проверка на ввод данных
  (edtcutName.Text<>'Название') and
  (edtStartEventTime.Text<>'  :  ') then
  begin
    //запись в массив
    FormMain.EV[FormMain.count].cutName:=edtcutName.Text;
    FormMain.EV[FormMain.count].EventDate:=dtpDateEvent.Date;
    FormMain.EV[FormMain.count].EventTime:=StrToTime(edtStartEventTime.Text);
    FormMain.EV[FormMain.count].opisanie:=MemoOpisanie.Text;
    inc(FormMain.count);
    //запись в файл
    AssignFile(F,FormMain.dir+formmain.h.name+'events');
    Reset(f);
    Seek(f,0);
    for i:=0 to FormMain.count-1  do
      write(f,formmain.ev[i]);
    CloseFile(f);
    FormMain.MonthCalendar1.OnClick(FormMain.MonthCalendar1);
    FormAddEvent.Close;
  end
  else
    ShowMessage('Заполните поля!');
end;

procedure TFormAddEvent.ButtonCancelClick(Sender: TObject);
begin
    FormAddEvent.Close;
end;

procedure TFormAddEvent.FormCreate(Sender: TObject);
begin
  dtpDateEvent.date:=Now;
end;

end.
