# AutoForm (aldeed:autoform) config

    AutoForm.hooks
      onError: (formType, error) ->
        sweetAlert 'Oh no!', error.reason, 'error'
