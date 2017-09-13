<template>
  <div>
    <q-spinner-mat size="50px" color="primary"></q-spinner-mat>
  </div>
</template>

<script>
import { QSpinnerMat } from 'quasar'
export default {
  components: {
    QSpinnerMat
  },
  name: 'callback',
  props: ['auth'],
  data () {
    this.auth.handleAuthentication()
    return {}
  }
}
</script>
