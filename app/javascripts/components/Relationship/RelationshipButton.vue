<template>
  <div>
    <div v-if="isRelationshiped" @click="deleteRelationship()" class="btn btn-bg follow-followed">
      <i class="fas fa-user-minus"></i> フォロー解除
    </div>
    <div v-else @click="registerRelationship()" class="btn btn-bg" style="margin:0;">
      <i class="fas fa-user-plus"></i> フォローする
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

export default {
  props: ['followerId', 'followedId'],
  data() {
    return {
      followerIds: [],
      isRelationshiped: false,
    }
  },
  computed: {
    // count() {
    //   return this.relationshipList.length
    // },
    isRelationshiped() {
      return this.isFollow()
    }
  },
  async created() {
    const res = await this.fetchRelationshipByFollowedId()
    // this.relationshipList = res
    this.followerIds = res.map(e => e.follower_id)
    this.isRelationshiped = this.isFollow()
  },
  methods: {
    async fetchRelationshipByFollowedId() {
      const res = await axios.get(`/api/relationships/?followed_id=${this.followedId}`)
      if (res.status !== 200) { process.exit() }
      return res.data
    },
    async registerRelationship() {
      const res = await axios.post('/api/relationships', { followed_id: this.followedId })
      if (res.status !== 201) { process.exit() }
      this.followerIds.push(Number(this.followerId))
      // this.isRelationshiped = this.isFollow()
    },
    async deleteRelationship() {
      const res = await axios.delete(`/api/relationships/${this.followedId}`)
      if (res.status !== 200) { process.exit() }
      this.followerIds = this.followerIds.filter((e) => e !== this.followerId)
      // this.isRelationshiped = this.isFollow()
    },
    isFollow() {
      return this.followerIds.includes(this.followerId)
    },
  }
}
</script>
