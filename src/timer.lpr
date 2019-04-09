program TimerProject;

uses
  SysUtils,
  Classes,
  CustApp,
  DateUtils,
  Views,
  Crt;

const
  VK_ESC = #27;
  VK_ENTER = #13;

procedure Cleanup;
begin
  while KeyPressed do
    ReadKey;
  TextBackground(Black);
  TextColor(White);
  NormVideo;
  ClearScreen;
end;

var
  StartTime: TDateTime;
  Previous, TimerSeconds, AvailableSeconds, ElapsedSeconds: integer;
  Finished: boolean;
begin
  StartTime := Now;
  Finished := False;
  Previous := 0;

  TimerSeconds := 25 * 60;
  if ParamCount = 1 then
    TimerSeconds := Round(StrToFloat(ParamStr(1)) * 60);

  repeat
    repeat
      ElapsedSeconds := SecondsBetween(Now, StartTime);
      AvailableSeconds := TimerSeconds - ElapsedSeconds;
      if Previous <> AvailableSeconds then
        DrawTimer(ElapsedSeconds, AvailableSeconds);
      Previous := AvailableSeconds;
      Sleep(500);
    until KeyPressed;

    while KeyPressed do
      case ReadKey of
        VK_ESC: Finished := True;
        VK_ENTER: StartTime := Now;
      end;
  until Finished;

  Cleanup;
end.
