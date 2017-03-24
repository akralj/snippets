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
