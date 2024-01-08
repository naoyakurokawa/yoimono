<template>
  <div>
    <div
      v-if="isRelationshiped"
      class="btn btn-bg follow-followed"
      @click="deleteRelationship()"
    >
      <i class="fas fa-user-minus"></i> フォロー解除
    </div>
    <div
      v-else
      class="btn btn-bg"
      style="margin: 0"
      @click="registerRelationship()"
    >
      <i class="fas fa-user-plus"></i> フォローする
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

export default {
  props: {
    followerId: {
      type: Number,
      default: 0,
    },
    followedId: {
      type: Number,
      default: 0,
    },
  },
  data() {
    return {
      followerIds: [],
    }
  },
  computed: {
    isRelationshiped() {
      return this.isFollow()
    },
  },
  async created() {
    const res = await this.fetchRelationshipByFollowedId()
    this.followerIds = res.map((e) => e.follower_id)
    this.isRelationshiped = this.isFollow()
  },
  methods: {
    async fetchRelationshipByFollowedId() {
      const res = await axios.get(
        `/api/relationships/?followed_id=${this.followedId}`,
      )
      return res.data
    },
    async registerRelationship() {
      await axios.post('/api/relationships', {
        followed_id: this.followedId,
      })
      this.followerIds.push(Number(this.followerId))
    },
    async deleteRelationship() {
      await axios.delete(`/api/relationships/${this.followedId}`)
      this.followerIds = this.followerIds.filter((e) => e !== this.followerId)
    },
    isFollow() {
      return this.followerIds.includes(this.followerId)
    },
  },
}
</script>
