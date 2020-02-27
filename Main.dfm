object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 517
  ClientWidth = 1103
  Caption = 'MainForm'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object dbgridContatos: TUniDBGrid
    Left = 446
    Top = 8
    Width = 649
    Height = 466
    Hint = ''
    DataSource = dsConnection
    LoadMask.Message = 'Loading data...'
    ForceFit = True
    TabOrder = 0
    Columns = <
      item
        FieldName = 'Nome'
        Title.Caption = 'Nome'
        Width = 300
      end
      item
        FieldName = 'Telefone'
        Title.Caption = 'Telefone'
        Width = 150
      end
      item
        FieldName = 'Email'
        Title.Caption = 'Email'
        Width = 200
      end>
  end
  object UniMemo1: TUniMemo
    Left = 8
    Top = 8
    Width = 409
    Height = 466
    Hint = ''
    Lines.Strings = (
      'UniMemo1')
    TabOrder = 1
  end
  object btnWhats: TUniButton
    Left = 887
    Top = 480
    Width = 101
    Height = 25
    Hint = ''
    Enabled = False
    Caption = 'Send Whatsapp'
    TabOrder = 2
    OnClick = btnWhatsClick
  end
  object btnLoad: TUniButton
    Left = 777
    Top = 480
    Width = 104
    Height = 25
    Hint = ''
    Caption = 'Load Contacts'
    TabOrder = 3
    OnClick = btnLoadClick
  end
  object edtCaminho: TUniEdit
    Left = 446
    Top = 480
    Width = 325
    Height = 25
    Hint = ''
    Text = ''
    TabOrder = 4
  end
  object btnSms: TUniButton
    Left = 994
    Top = 480
    Width = 101
    Height = 25
    Hint = ''
    Enabled = False
    Caption = 'Send SMS'
    TabOrder = 5
    OnClick = btnSmsClick
  end
  object UniFileUpload1: TUniFileUpload
    OnCompleted = UniFileUpload1Completed
    MaxAllowedSize = 1500000
    Title = 'Send File'
    Messages.Uploading = 'Uploading...'
    Messages.PleaseWait = 'Please Wait'
    Messages.Cancel = 'Cancel'
    Messages.Processing = 'Processing...'
    Messages.UploadError = 'Upload Error'
    Messages.Upload = 'Upload'
    Messages.NoFileError = 'Please Select a File'
    Messages.BrowseText = 'Browse...'
    Left = 16
    Top = 472
  end
  object dsConnection: TDataSource
    DataSet = fdmContacts
    Left = 88
    Top = 472
  end
  object fdmContacts: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 168
    Top = 472
    object fdmContactsNome: TStringField
      FieldName = 'Nome'
    end
    object fdmContactsTelefone: TStringField
      FieldName = 'Telefone'
    end
    object fdmContactsEmail: TStringField
      FieldName = 'Email'
    end
  end
  object UniSFSweetAlert1: TUniSFSweetAlert
    Timer = 0
    IsHtmlJS = False
    ConfirmButtonText = 'OK'
    CancelButtonText = 'Cancel'
    ConfirmButtonColor = '#3085d6'
    CancelButtonColor = '#d33'
    ShowConfirmButton = True
    ShowCancelButton = False
    Animation = True
    AlertType = atNone
    Position = top
    ImageWidth = 0
    ImageHeight = 0
    AllowOutsideClick = False
    AllowEscapeKey = False
    ScreenMask.Theme = ht_sk_rect
    Language = alEnglish
    Left = 264
    Top = 472
  end
end
