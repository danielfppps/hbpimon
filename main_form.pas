unit main_form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, TAIntervalSources, Forms,
  Controls, Graphics, Dialogs, StdCtrls, Menus, ExtCtrls, DateUtils;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    DateTimeIntervalChartSource1: TDateTimeIntervalChartSource;
    Label1: TLabel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Timer1StartTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    hb_record : TStringList;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  hb_record.SaveToFile(IntToStr(DateTimeToUnix(Now()))+'_run.txt');
  Chart1LineSeries1.Clear();
  hb_record.Clear();
  Application.ProcessMessages();
end;

procedure TForm1.Timer1StartTimer(Sender: TObject);
begin
  hb_record := TStringList.Create();
  Cursor := crNone;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  hb: TStringList;
  current_time : TDateTime;
begin
  hb := TStringList.Create();
  try
      hb.LoadFromFile('/home/pi/hb.txt');
      Label1.Caption := hb[0];
  except
      on E: Exception do
      begin
         hb.Free;
         Exit();
      end;
  end;
  current_time := Now() ;
  hb_record.Add(IntToStr(DateTimeToUnix(current_time))+','+hb[0]);
  Chart1LineSeries1.AddXY(current_time, StrToInt(hb[0]));
  hb.Free;
  Application.ProcessMessages();
end;

end.

