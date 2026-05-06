unit KTN_Type;

interface

type
    TKTNType = class(TObject)
    private
        fNote: string;
    public
        constructor Create;
        property Note: string read fNote write fNote;
    end;

implementation

{
*********************************** TKTNType ***********************************
}
constructor TKTNType.Create;
begin
    inherited Create;
    fNote:='';
end;


end.
