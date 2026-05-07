unit KTN_Data;
{$I config.inc}

interface

type
    TKTNData = class(TObject)
    private
        fNote: string;
    public
        constructor Create;
        property Note: string read fNote write fNote;
    end;

implementation

{$IF DEFINED(DEVELOPMENT)}uses KTN_console;{$IFEND}
{
*********************************** TKTNType ***********************************
}
constructor TKTNData.Create;
begin
    inherited Create;
    fNote:='';
end;


end.
