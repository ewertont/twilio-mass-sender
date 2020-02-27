unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIRegClasses,
  uniGUIForm, uniButton, Vcl.Dialogs, uniMemo, uniGUIBaseClasses, uniBasicGrid,
  uniDBGrid, uniEdit, uniFileUpload, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  TwilioClient, System.JSON, System.Net.HttpClient, UniSFSweetAlert;

type
  TMainForm = class(TUniForm)
    dbgridContatos: TUniDBGrid;
    UniMemo1: TUniMemo;
    btnWhats: TUniButton;
    btnLoad: TUniButton;
    edtCaminho: TUniEdit;
    UniFileUpload1: TUniFileUpload;
    dsConnection: TDataSource;
    fdmContacts: TFDMemTable;
    fdmContactsNome: TStringField;
    fdmContactsTelefone: TStringField;
    fdmContactsEmail: TStringField;
    btnSms: TUniButton;
    UniSFSweetAlert1: TUniSFSweetAlert;
    procedure btnLoadClick(Sender: TObject);
    procedure UniFileUpload1Completed(Sender: TObject; AStream: TFileStream);
    procedure btnSmsClick(Sender: TObject);
    procedure btnWhatsClick(Sender: TObject);
  private
    { Private declarations }
    var
      caminhoArquivo: string;
      client: TTwilioClient;
      allParams: TStringList;
      response: TTwilioClientResponse;
      json: TJSONValue;
      fromPhoneNumber: string;
      toPhoneNumber: string;
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, ServerModule, System.StrUtils;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.btnLoadClick(Sender: TObject);
begin
  UniFileUpload1.Execute;
end;

procedure TMainForm.btnWhatsClick(Sender: TObject);
begin
  try
    fdmContacts.First;
    while not fdmContacts.Eof do
    begin
      client := TTwilioClient.Create('#ACCOUNT SID',
        '#AUTH TOKEN');

      fromPhoneNumber := '#SENDERNUMBER';

      toPhoneNumber := '#RECEIVERNUMBER';

      allParams := TStringList.Create;
      allParams.Add('From=' + fromPhoneNumber);
      allParams.Add('To=' + toPhoneNumber);
      allParams.Add('Body=Look this Owl');
      allParams.Add('MediaUrl=https://www.audubon.org/sites/default/files/styles/hero_cover_bird_page/public/web_a1_3751_8_barn-owl_shlomo_neuman_kk-adult-male_copy.jpg?itok=D0tHCXv5');

      response := client.Post('Messages', allParams);
      if response.Success then
        ShowMessage('Message SID: ' + response.ResponseData.GetValue<string>('sid'))
      else if response.ResponseData <> nil then
        ShowMessage(response.ResponseData.ToString)
      else
        ShowMessage('HTTP status: ' + response.HTTPResponse.StatusCode.ToString);
      fdmContacts.Next;
    end;
  finally
    client.Free;
  end;
end;

procedure TMainForm.btnSmsClick(Sender: TObject);
begin
  try
    fdmContacts.First;
    while not fdmContacts.Eof do
    begin
      client := TTwilioClient.Create('#ACCOUNT SID',
        '#AUTH TOKEN');

      fromPhoneNumber := '#SENDERNUMBER';

      toPhoneNumber := '#RECEIVERNUMBER';

      allParams := TStringList.Create;
      allParams.Add('From=' + fromPhoneNumber);
      allParams.Add('To=' + toPhoneNumber);
      allParams.Add('Body=Hi, Delphi is Nice!');

      response := client.Post('Messages', allParams);
      if response.Success then
        ShowMessage('Message SID: ' + response.ResponseData.GetValue<string>('sid'))
      else if response.ResponseData <> nil then
        ShowMessage(response.ResponseData.ToString)
      else
        ShowMessage('HTTP status: ' + response.HTTPResponse.StatusCode.ToString);
      fdmContacts.Next;
    end;
  finally
    client.Free;
  end;
end;

procedure TMainForm.UniFileUpload1Completed(Sender: TObject; AStream: TFileStream);
var
  DestFolder, DestName: string;
  Lista: TStringList;
  I, J, Li, Lf: integer;
  L, Sub: string[80];
  TipoCampo: TFieldType;
  campo: Variant;
begin
  DestFolder := ExtractFileDir(UniServerModule.StartPath) + '\files';
  DestName := DestFolder + '\' + ExtractFileName(UniFileUpload1.FileName);
  if not CopyFile(PChar(AStream.FileName), PChar(DestName), False) then
    ShowMessage('Fail on copy file. ' + SysErrorMessage(GetLastError()));


  UniMemo1.Lines.LoadFromFile(DestName);

  edtCaminho.Text := DestName;

  Lista := TStringList.Create;
  Lista.LoadFromFile(DestName);
  fdmContacts.Close;
  fdmContacts.Open;
  fdmContacts.EmptyDataSet;
  for I := 0 to Lista.Count - 1 do
  begin
    L := Lista.Strings[I];
    Lf := 0;
    Li := 1;
    J := 0;
    fdmContacts.Insert;
    repeat
      Lf := PosEx(',', L, Lf + 1);
      if Lf = 0 then
        Lf := Length(L) + 1;
      Sub := Copy(L, Li, Lf - Li);
      campo := Sub;
      case J of
        0:
          fdmContactsNome.AsString := campo;
        1:
          fdmContactsTelefone.AsString := campo;
        2:
          fdmContactsEmail.AsString := campo;
      else
        fdmContacts.Fields.Fields[J].AsVariant := campo;
      end;
      Inc(J);
      Li := Lf + 1;
    until Lf > Length(L);
    fdmContacts.Post;
  end;
  //fdmContacts.Close;
  Lista.Free;
  btnWhats.Enabled := True;
  btnSms.Enabled := True;

end;

initialization
  RegisterAppFormClass(TMainForm);

end.

