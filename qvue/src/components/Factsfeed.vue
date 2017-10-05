<template>
  <div>
    <q-list highlight>
      <q-list-header>Facts feed</q-list-header>
      <q-item v-for="fact in facts" :key="fact.id">
        <q-item-side stamp>{{fact.id}}</q-item-side>
        <q-item-main>
          <q-item-tile label>{{fact.title}}</q-item-tile>
        </q-item-main>
      </q-item>
    </q-list>
  </div>
</template>

<script>

import FactsfeedService from './FactsfeedService'

import {
  QList,
  QListHeader,
  QItem,
  QItemSeparator,
  QItemSide,
  QItemMain,
  QItemTile,
  QChip,
  QPopover
} from 'quasar'

const feedService = new FactsfeedService()
export default {
  components: {
    QList,
    QListHeader,
    QItem,
    QItemSeparator,
    QItemSide,
    QItemMain,
    QItemTile,
    QChip,
    QPopover
  },
  name: 'factsfeed',
  data: function () {
    return {
      facts: []
    }
  },
  mounted: function () {
    var vm = this
    feedService.loadFacts(vm)
  }
}
</script>
