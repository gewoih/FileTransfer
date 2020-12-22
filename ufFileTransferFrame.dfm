object MainFrame: TMainFrame
  Left = 0
  Top = 0
  Width = 985
  Height = 569
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object MainTree: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 985
    Height = 569
    Align = alClient
    Alignment = taCenter
    Colors.BorderColor = 15987699
    Colors.DisabledColor = clGray
    Colors.DropMarkColor = 15385233
    Colors.DropTargetColor = 15385233
    Colors.DropTargetBorderColor = 15987699
    Colors.FocusedSelectionColor = 15385233
    Colors.FocusedSelectionBorderColor = clWhite
    Colors.GridLineColor = 15987699
    Colors.HeaderHotColor = clBlack
    Colors.HotColor = clBlack
    Colors.SelectionRectangleBlendColor = 15385233
    Colors.SelectionRectangleBorderColor = 15385233
    Colors.SelectionTextColor = clBlack
    Colors.TreeLineColor = 9471874
    Colors.UnfocusedColor = 9695616
    Colors.UnfocusedSelectionColor = 15385233
    Colors.UnfocusedSelectionBorderColor = 15385233
    Colors.HeaderColor = 9695616
    DefaultNodeHeight = 25
    Header.AutoSizeIndex = 0
    Header.DefaultHeight = 25
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -13
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.Height = 28
    PopupMenu = PopupMenu1
    TabOrder = 0
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toVariableNodeHeight, toEditOnClick, toEditOnDblClick]
    OnEditing = MainTreeEditing
    OnGetText = MainTreeGetText
    OnNewText = MainTreeNewText
    ExplicitLeft = -3
    ExplicitTop = 3
    Columns = <
      item
        Position = 0
        Width = 56
        Aggregate = False
        FilterMode = 0
        WideText = 'ID'
      end
      item
        Position = 1
        Width = 239
        Aggregate = False
        FilterMode = 0
        WideText = #1053#1072#1079#1074#1072#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      end
      item
        Position = 2
        Width = 148
        Aggregate = False
        FilterMode = 0
        WideText = #1048#1084#1103' '#1092#1072#1081#1083#1072
      end
      item
        Position = 3
        Width = 163
        Aggregate = False
        FilterMode = 0
        WideText = #1042#1077#1088#1089#1080#1103
      end>
  end
  object OpenDialog1: TOpenDialog
    Left = 32
    Top = 40
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.fr3'
    Filter = #1054#1090#1095#1077#1090' fr3|*.fr3|PDF '#1092#1072#1081#1083'|*.pdf'
    Options = []
    Left = 112
    Top = 40
  end
  object PopupMenu1: TPopupMenu
    Left = 192
    Top = 40
    object N1: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      OnClick = N1Click
    end
    object N3: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      OnClick = N3Click
    end
    object N2: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      OnClick = N2Click
    end
  end
end
