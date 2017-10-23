# right aligned tabs in header
label =
  view: 'label'
  label: 'Header Text'

tabbar =
  width: 200
  view: 'segmented'
  value: 'view1'
  multiview: true
  options: [
    { value: 'Admin', width: 100, id: 'view1' }
    { value: 'Monitoring', width: 100, id: 'view2' }
  ]

webix.ui
  type: 'line'
  rows: [
    {
      paddingX: 20
      paddingY: 7
      cols: [label, tabbar]
    }
    {
      animate: false
      cells: [
        { id: 'view1', view: 'template', template: 'view1'}
        { id: 'view2', view: 'template', template: 'view2'}
      ]
    }
  ]


# webix button in datatable
webix.protoUI { name: 'activeTable' }, webix.ui.datatable, webix.ActiveContent
webix.ui
  id: 'table1'
  view: 'activeTable'
  data: grid_data
  rowLineHeight: 25
  columns: [
    {}
    {
      id: 'button'
      template: '{common.yourButton()}'
      fillspace: true
    }
  ]
  activeContent: yourButton:
    id: 'button1'
    view: 'button'
    label: 'Click'
    width: 70
    height: 30
    click: (id, e) ->


# databindging
vw1 =
  id: 'vw1'
  template: 'text: #text#'
vw2 =
  id: 'vw2'
  template: 'text: #text#'
input =
  id: 'input'
  view: 'text'
  label: 'text'
  name: 'text'
webix.ui rows: [
  input
  { cols: [vw1, vw2 ] }
]

useModel = (id) ->
  vw = $$(id)

  vw.setModel = (model) ->
    vw.setValues model.getData()
    model.onDirty (data) -> vw.setValues data


['vw1','vw2'].forEach useModel

Model = (data) ->
  _data = data
  _obs = []
  {
    getData: ->
      _data
    setData: (data) ->
      _data = data
      _obs.forEach (o) ->   o _data

    onDirty: (f) -> _obs.push f
  }

model = Model(text: '')
$$('vw1').setModel model
$$('vw2').setModel model
$$('input').attachEvent 'onTimedKeyPress', -> model.setData text: $$('input').getValue()
