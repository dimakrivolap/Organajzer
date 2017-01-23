unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, UnitReg, MPlayer, JPEG;

type
      pt=^event;
      Event=record
        cutName:string[30];
        EventDate:TDate;
        EventTime:TTime;
        opisanie: string[255];
        next: pt;
      end;

procedure Make(Var x:pt);
procedure Sort(Var x:pt);
procedure Delt(Var x:pt);

type
  Alarms = record
    Date:TDate;
    Time:TTime;
    Comments:string[30];
  end;

type
  TFormMain = class(TForm)
    raspisanie: TImage;
    MonthCalendar1: TMonthCalendar;
    LableTimeShow: TLabel;
    ButomAlarm: TButton;
    lstNameEvent: TListBox;
    lstDateEvent: TListBox;
    MemoOpisanie: TMemo;
    ButtonAdd: TButton;
    ButtonSave: TButton;
    ButtonExit: TButton;
    lblPlan: TLabel;
    ButtonDelete: TButton;
    lblevent: TLabel;
    lbltexttime: TLabel;
    lbopisanie: TLabel;
    tmr1: TTimer;
    tmr2: TTimer;
    lbl1: TLabel;
    mp1: TMediaPlayer;
    lbl2: TLabel;
    lbl3: TLabel;
    btnsort: TButton;
    btnhelp: TButton;
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    procedure ButomAlarmClick(Sender: TObject);
    procedure lstNameEventClick(Sender: TObject);
    procedure lstDateEventClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmr2Timer(Sender: TObject);
    procedure MonthCalendar1Click(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure btnsortClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure btnhelpClick(Sender: TObject);
  private

  public
    head,first:pt;
    count,k: integer;
    count_alarms:Integer;
    ev: array[0..10000] of event;
    dir:string;
    h:human;
    al:array[0..10000] of Alarms;
    opis: array[0..10000] of string;
  end;
var
  FormMain: TFormMain;

implementation

uses UnitAddEvent, UnitVhod, UnitAddAlarm;

{$R *.dfm}

procedure TFormMain.ButtonAddClick(Sender: TObject);
begin
  FormAddEvent.show;
end;

procedure TFormMain.ButtonExitClick(Sender: TObject);
begin
  FormVhod.close;
end;

procedure TFormMain.ButomAlarmClick(Sender: TObject);
begin
  FormAlarm.show;
end;

procedure TFormMain.lstNameEventClick(Sender: TObject);
var i:Integer;
begin
  lstDateEvent.ItemIndex:=lstNameEvent.ItemIndex;
  for i:=0 to count-1 do
  begin
    lbl2.Caption:=DateToStr(MonthCalendar1.date);
    lbl3.Caption:=DateToStr(ev[i].EventDate);
    if lbl2.Caption=lbl3.Caption then
      MemoOpisanie.Text:=EV[i-(lstDateEvent.Items.count-lstDateEvent.ItemIndex)+1].opisanie;
  end;
end;


procedure TFormMain.lstDateEventClick(Sender: TObject);
var i:Integer;
begin
  lstNameEvent.ItemIndex:=lstDateEvent.ItemIndex;
  for i:=0 to count-1 do
  begin
    lbl2.Caption:=DateToStr(MonthCalendar1.date);
    lbl3.Caption:=DateToStr(ev[i].EventDate);
    if lbl2.Caption=lbl3.Caption then
    //обновление мемо на нужное событие
      MemoOpisanie.Text:=EV[i-(lstDateEvent.Items.count-lstDateEvent.ItemIndex)+1].opisanie;
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  count:=0;//количество событий
  k:=0;    //дополнительный счетчик событий
  count_alarms:=0; //счетчик будильников
  dir:='Users/';
  //по умолчанию дата=сегодн€
  MonthCalendar1.Date:=now;

  //вывод на форму списка


end;

procedure TFormMain.FormShow(Sender: TObject);
var
  i:integer;
  t: file of Alarms;
begin
    case StrToInt(h.group) of  //загрузка картинки группы
    451001 : raspisanie.Picture.LoadFromFile('Group/451001.jpg');
    451002 : raspisanie.Picture.LoadFromFile('Group/451002.jpg');
    451003 : raspisanie.Picture.LoadFromFile('Group/451003.jpg');
    451004 : raspisanie.Picture.LoadFromFile('Group/451004.jpg');
    451005 : raspisanie.Picture.LoadFromFile('Group/451005.jpg');
    451006 : raspisanie.Picture.LoadFromFile('Group/451006.jpg');
  end;
  for i:=0 to count-1 do
  begin
    lbl2.Caption:=DateToStr(MonthCalendar1.date);
    lbl3.Caption:=DateToStr(ev[i].EventDate);
    if lbl2.Caption=lbl3.Caption then
    begin
      lstNameEvent.Items.Add(EV[i].cutName);
      lstDateEvent.Items.Add(TimeToStr(EV[i].EventTime));
      opis[i]:=EV[i].opisanie;
    end;
  end;
  AssignFile(t,dir+h.name+'alarms');
  Reset(t);
  while not Eof(t) do
  begin
    Read(t,al[count_alarms]); //загрузка будильников
    inc(count_alarms);
  end;
  CloseFile(t);
end;

procedure TFormMain.tmr1Timer(Sender: TObject);
begin
  lableTimeShow.Caption:=timetostr(time);
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TFormMain.tmr2Timer(Sender: TObject);
var i:Integer;
begin
  lbl1.Caption:=DateToStr(now);
  for i:=0 to count_alarms do
    if al[i].Date = StrToDate(lbl1.Caption) then
      if al[i].Time = StrToTime(LableTimeShow.Caption) then
      begin   //проверка на будильник
        mp1.Open;
        mp1.Play;
        if al[i].Comments<>'' then
          ShowMessage(al[i].Comments)
        else
          ShowMessage('Ѕудильник');
        mp1.Stop;
      end;
end;

procedure TFormMain.MonthCalendar1Click(Sender: TObject);
var i:Integer;
begin
  lstDateEvent.Items.Clear;  //отчистка строк даты событи€
  lstNameEvent.Items.Clear;  //отчистка строк названи€ событи€
  MemoOpisanie.Text:='';
  for i:=0 to count-1 do
  begin
    lbl2.Caption:=DateToStr(MonthCalendar1.date);
    lbl3.Caption:=DateToStr(ev[i].EventDate);
    if lbl2.Caption=lbl3.Caption then   //сравнение дат
    begin
      lstNameEvent.Items.Add(EV[i].cutName);//добавление названи€
      lstDateEvent.Items.Add(TimeToStr(EV[i].EventTime));//даты
      MemoOpisanie.Text:=EV[i].opisanie;  //описани€
      opis[i]:=EV[i].opisanie;
    end;
  end;
  k:=0;
end;

procedure TFormMain.ButtonDeleteClick(Sender: TObject);
var i:Integer;
f: file of Event;
begin
  Dec(count);
  AssignFile(F,dir+h.name+'events');
  Rewrite(f);
  Seek(f,0);
  //перезапись файла без выбранного событи€
  if lstNameEvent.ItemIndex<>-1 then
  begin
    for i:=0 to count  do
    begin
      if (ev[i].cutName  <> lstNameEvent.Items.Strings[lstNameEvent.ItemIndex]) and
         (ev[i].opisanie <> MemoOpisanie.Text) then
      begin
        write(f,ev[i]);
        ev[k]:=ev[i];
        Inc(k);
      end;
    end;
    CloseFile(f);
    if lbl2.Caption=lbl3.Caption then
    begin
      lstDateEvent.Items.Delete(lstDateEvent.ItemIndex);
      lstNameEvent.Items.Delete(lstNameEvent.ItemIndex);
      MemoOpisanie.Text:='';
    end;
    //программное нажатие кнопки календар€
    //дл€ обновлени€ записей
    MonthCalendar1.OnClick(MonthCalendar1);
  end
  else
  ShowMessage('¬ыберете событие дл€ удалени€!');
end;

procedure Make(var x:pt);
var i: Integer;
begin
  //создание однонаправленного списка
  new(x);
  FormMain.head:=x;
  for i:=0 to FormMain.count-1 do
  begin
    new(x^.next);
    x:=x^.next;
    x^.cutname:=FormMain.ev[i].cutname;
    x^.EventDate:=FormMain.ev[i].EventDate;
    x^.EventTime:=FormMain.ev[i].EventTime;
    x^.opisanie:=FormMain.ev[i].opisanie;
    x^.next:=nil;
  end;
end;

procedure Delt(Var x:pt);
begin
  //освобождение пам€ти
  while x.next<>nil do
    begin
      Dispose(x);
      x:=x.next
    end;
    Dispose(x.next);
end;

procedure Sort(var x:pt);
var
  i: integer;
  buf: Event;
  p:pt;
  f: file of Event;
begin
  //сортировка однонаправленного списка
  //и перезапись в файл
  //уже отсортированых элементов
  i:=0;
  p:=FormMain.head;
  p:=p.next;
  while p.next<>nil do
  begin
    if p^.EventDate=p.next^.EventDate then
    begin
      if p^.EventTime>p.next^.EventTime then
      begin
        buf:=FormMain.ev[i];
        FormMain.ev[i]:=FormMain.ev[i+1];
        FormMain.ev[i+1]:=buf;
      end;
    end;
    Inc(i);
    p:=p.next;
  end;
  AssignFile(F,FormMain.dir+FormMain.h.name+'events');
  Rewrite(f);
  Seek(f,0);
  for i:=0 to FormMain.count  do
    write(f,FormMain.ev[i]);
  CloseFile(f);
end;

procedure TFormMain.btnsortClick(Sender: TObject);
var i: integer;
begin
  if count>0 then
  begin
    for i:=0 to count do
    begin
      make(first);
      sort(first);
      Delt(first);
    end;
  end
  else
  ShowMessage('—писок пуст!');
  MonthCalendar1.OnClick(MonthCalendar1);
end;

procedure TFormMain.ButtonSaveClick(Sender: TObject);
var f: file of Event;
    i,n:integer;
begin
  n:=1;
  //сохранение изменений в мемо
  if lstNameEvent.ItemIndex<>-1 then
  begin
    for i:=0 to count  do
    begin
      if (ev[i].cutName   = lstNameEvent.Items.Strings[lstNameEvent.ItemIndex]) and
         (TimeToStr(ev[i].EventTime) = lstDateEvent.Items.Strings[lstDateEvent.ItemIndex]) then
      begin
        ev[i].opisanie:=MemoOpisanie.Text;
        n:=i;
      end;
    end;
    //перезапись в файл
    AssignFile(F,FormMain.dir+FormMain.h.name+'events');
    Rewrite(f);
    Seek(f,0);
    for i:=0 to FormMain.count  do
      write(f,FormMain.ev[i]);
    CloseFile(f);
    MonthCalendar1.OnClick(MonthCalendar1);
    lstDateEvent.ItemIndex:=n;
    lstNameEvent.ItemIndex:=n;
    MemoOpisanie.Text:=ev[n].opisanie;
    ShowMessage('—охранено');
  end
  else
  ShowMessage('¬ыберете Ёлемент!');
end;

procedure TFormMain.btnHelpClick(Sender: TObject);
var f: TextFile;
text,t:string;
begin
  //чтение из текстового файла
  AssignFile( f , 'help.txt'); // открыть файл
  FileMode := fmOpenRead;
  Reset(f);
  while not Eof(f) do
  begin
    ReadLn(f, t);
    //char(10) сдвиг коретки в начало
    //char(13) сдвиг на новую строку
    text:=text+t+char(10)+char(13);
  end;            //
  ShowMessage(text);
  CloseFile(f);
end;
end.
