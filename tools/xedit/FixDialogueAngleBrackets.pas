unit FixDialogueAngleBrackets;

{
  SSEEdit / xEdit script.

  Player dialogue prompts that use angle-bracket "stage directions" such as
  <Walk away> render as INVISIBLE / blank menu entries in-game, because the
  engine treats <...> as markup. This converts those to square brackets:
  <Walk away> -> [Walk away].

  IMPORTANT - it is surgical, not a blanket replace:
    * It only rewrites a <...> segment when that segment contains NO '='.
    * Functional Creation Kit text tags ( <Global=HPWhiterun>, <Alias=Player>,
      <Alias.ShortName=Friend>, ... ) all contain '=', so they are LEFT ALONE.
      A blanket < -> [ replace would break those (e.g. house prices).

  Fields touched (player-facing menu text only):
    DIAL -> FULL (Topic Text)
    INFO -> RNAM (Prompt)
  NPC response lines (INFO\NAM1, the <pats you...> emote subtitles) are NOT
  touched - this is about the player's menu choices.

  How to run:
    1. Load SL Survival.esp in xEdit.
    2. Right-click it (or its Dialog Topic / Topic Info groups)
       -> Apply Script... -> "FixDialogueAngleBrackets" -> OK.
    3. Every change is logged - review them.
    4. Close xEdit and let it save (it backs up the plugin first).
  Safe to re-run; only acts on text that still has a non-functional <...>.
}

// Replace each <...> with [...] UNLESS the segment contains '=' (functional tag).
function FixAngles(s: string): string;
var
  i, j: Integer;
  inner: string;
begin
  Result := '';
  i := 1;
  while i <= Length(s) do begin
    if s[i] = '<' then begin
      j := i + 1;
      while (j <= Length(s)) and (s[j] <> '>') do
        j := j + 1;
      if j <= Length(s) then begin
        inner := Copy(s, i + 1, j - i - 1);
        if Pos('=', inner) = 0 then
          Result := Result + '[' + inner + ']'   // free-text action -> fix
        else
          Result := Result + '<' + inner + '>';  // functional tag -> keep
        i := j + 1;
      end else begin
        // unmatched '<' : copy the remainder verbatim and stop
        Result := Result + Copy(s, i, Length(s) - i + 1);
        i := Length(s) + 1;
      end;
    end else begin
      Result := Result + s[i];
      i := i + 1;
    end;
  end;
end;

procedure FixField(e: IInterface; path: string; fieldLabel: string);
var
  cur, fixed: string;
begin
  if not ElementExists(e, path) then Exit;
  cur := GetElementEditValues(e, path);
  if Pos('<', cur) = 0 then Exit;
  fixed := FixAngles(cur);
  if fixed <> cur then begin
    SetElementEditValues(e, path, fixed);
    AddMessage(Format('  %s  %s: "%s"  ->  "%s"', [Name(e), fieldLabel, cur, fixed]));
  end;
end;

function Initialize: Integer;
begin
  AddMessage('=== Fix player-prompt angle brackets:  <action> -> [action]  (functional <X=Y> tags kept) ===');
  Result := 0;
end;

function Process(e: IInterface): Integer;
var
  sig: string;
begin
  Result := 0;
  sig := Signature(e);
  if sig = 'DIAL' then
    FixField(e, 'FULL', 'Topic Text')
  else if sig = 'INFO' then
    FixField(e, 'RNAM', 'Prompt');
end;

function Finalize: Integer;
begin
  AddMessage('=== Done. Review the changes above, then save. ===');
  Result := 0;
end;

end.
