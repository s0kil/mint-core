module Maybe {
  fun nothing : Maybe(a) {
    `new Nothing`
  }

  fun just (value : a) : Maybe(a) {
    `new Just(value)`
  }

  fun isJust (maybe : Maybe(a)) : Bool {
    `maybe instanceof Just`
  }

  fun map (func : Function(a, b), maybe : Maybe(a)) : Maybe(b) {
    `
    (() => {
     	if (maybe instanceof Just) {
     		return new Just(func(maybe.value))
     	} else {
     		return maybe
     	}
    })()
    `
  }

  fun withDefault (value : a, maybe : Maybe(a)) : a {
    `
    (() => {
    	if (maybe instanceof Just) {
    		return maybe.value
    	} else {
    		return value
    	}
    })()
    `
  }
}
