object FormReg: TFormReg
  Left = 460
  Top = 160
  Width = 486
  Height = 395
  BorderIcons = []
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblLogin: TLabel
    Left = 152
    Top = 48
    Width = 70
    Height = 29
    Caption = #1051#1086#1075#1080#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblLablePassword: TLabel
    Left = 136
    Top = 88
    Width = 86
    Height = 29
    Caption = #1055#1072#1088#1086#1083#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblpassword: TLabel
    Left = 8
    Top = 128
    Width = 215
    Height = 29
    Caption = #1055#1086#1074#1090#1086#1088#1080#1090#1077' '#1087#1072#1088#1086#1083#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblgroup: TLabel
    Left = 56
    Top = 168
    Width = 166
    Height = 29
    Caption = #1053#1086#1084#1077#1088' '#1075#1088#1091#1087#1087#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object edtPassword: TEdit
    Left = 248
    Top = 96
    Width = 209
    Height = 21
    MaxLength = 20
    PasswordChar = '*'
    TabOrder = 1
  end
  object edtpassword1: TEdit
    Left = 248
    Top = 136
    Width = 209
    Height = 21
    MaxLength = 20
    PasswordChar = '*'
    TabOrder = 2
  end
  object edtLogin: TEdit
    Left = 248
    Top = 56
    Width = 209
    Height = 21
    MaxLength = 20
    TabOrder = 0
  end
  object edtGroup: TEdit
    Left = 248
    Top = 168
    Width = 209
    Height = 21
    MaxLength = 6
    TabOrder = 3
    Text = '4510*'
  end
  object btnOK: TButton
    Left = 40
    Top = 272
    Width = 185
    Height = 41
    Caption = 'OK'
    TabOrder = 4
    OnClick = btnOKClick
  end
  object btnExit: TButton
    Left = 248
    Top = 272
    Width = 185
    Height = 41
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 5
    OnClick = btnExitClick
  end
end
