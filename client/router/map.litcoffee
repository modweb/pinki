# Router map

    Router.map ->
      @route 'home',
        path: '/'
        controller: RouteControllers.allPinkis
      @route 'create',
        template: 'createPinki'
        path: '/create'
      @route 'pinki',
        template: 'pinkiDetails'
        path: '/pinki/:_id'
        controller: RouteControllers.singlePinki
