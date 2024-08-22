object TFrTasks: TTFrTasks
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Tasks'
  ClientHeight = 415
  ClientWidth = 768
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  DesignSize = (
    768
    415)
  TextHeight = 17
  object Shape1: TShape
    Left = 19
    Top = 364
    Width = 740
    Height = 3
    Anchors = [akBottom]
    Pen.Width = 2
  end
  object labSequencial: TLabel
    Left = 19
    Top = 57
    Width = 75
    Height = 20
    Caption = 'Sequencial:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object labParalelo: TLabel
    Left = 399
    Top = 57
    Width = 56
    Height = 20
    Caption = 'Paralelo:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object pgbSequencial: TProgressBar
    Left = 19
    Top = 328
    Width = 360
    Height = 30
    Anchors = [akBottom]
    Step = 1
    TabOrder = 4
  end
  object pgbParalelo: TProgressBar
    Left = 399
    Top = 328
    Width = 360
    Height = 30
    Anchors = [akBottom]
    Step = 1
    TabOrder = 6
  end
  object btnFechar: TButton
    Left = 659
    Top = 373
    Width = 100
    Height = 40
    Anchors = [akBottom]
    Caption = 'Fechar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = btnFecharClick
  end
  object btnLimpar: TButton
    Left = 553
    Top = 373
    Width = 100
    Height = 40
    Anchors = [akBottom]
    Caption = 'Limpar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = btnLimparClick
  end
  object memSequencial: TMemo
    Left = 19
    Top = 79
    Width = 360
    Height = 245
    ReadOnly = True
    TabOrder = 3
  end
  object memParalelo: TMemo
    Left = 399
    Top = 79
    Width = 360
    Height = 245
    ReadOnly = True
    TabOrder = 5
  end
  object btnSelecFile: TButton
    Left = 19
    Top = 11
    Width = 110
    Height = 40
    Caption = 'Selecionar...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnSelecFileClick
  end
  object edtFilePath: TEdit
    Left = 138
    Top = 19
    Width = 505
    Height = 25
    ReadOnly = True
    TabOrder = 1
  end
  object btnIniciar: TButton
    Left = 659
    Top = 11
    Width = 100
    Height = 40
    Anchors = [akBottom]
    Caption = 'Iniciar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnIniciarClick
  end
  object dlgFile: TOpenDialog
    Left = 96
    Top = 368
  end
end
