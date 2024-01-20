<template>
  <div class="pc-menu">
    <nav>
      <ul v-if="isLogin">
        <li><a href="/items/new">モノ登録</a></li>
        <li><a href="/mypage">マイページ</a></li>
        <li><a data-method="delete" href="/logout">ログアウト</a></li>
      </ul>
      <ul v-else>
        <li><a href="/users/new">会員登録</a></li>
        <li><a href="/login">ログイン</a></li>
      </ul>
    </nav>
  </div>
  <div class="sp-menu" @click="click()">
    <span id="open" :class="{ 'material-icons': true, hide: isOpen }"
      >menu</span
    >
  </div>
  <div :class="{ overlay: true, show: isOpen }">
    <span id="close" class="material-icons" @click="click()">close</span>
    <nav>
      <ul v-if="isLogin">
        <li><a href="/items/new">モノ登録</a></li>
        <li><a href="/mypage">マイページ</a></li>
        <li><a data-method="delete" href="/logout">ログアウト</a></li>
      </ul>
      <ul v-else>
        <li><a href="/users/new">会員登録</a></li>
        <li><a href="/login">ログイン</a></li>
      </ul>
    </nav>
  </div>
</template>

<script>
export default {
  props: {
    isLogin: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      isOpen: false,
    }
  },
  created() {
    console.log(this.isLogin)
  },
  methods: {
    click() {
      this.isOpen = !this.isOpen
      console.log(this.isOpen)
    },
  },
}
</script>

<style lang="scss">
.sp-menu {
  margin-left: auto;
}

.sp-menu #open {
  font-size: 32px;
  cursor: pointer;
}

.sp-menu #open.hide {
  display: none;
}

main {
  padding: 0 16px;
}

.overlay {
  position: fixed;
  top: 0;
  bottom: 0;
  right: 0;
  left: 0;
  background: #333;
  text-align: center;
  padding: 64px;
  opacity: 0;
  pointer-events: none;
  transition: opacity 0.6s;
}

.overlay.show {
  opacity: 1;
  pointer-events: auto;
  z-index: 1;
}

.overlay #close {
  position: absolute;
  top: 16px;
  right: 16px;
  font-size: 32px;
  cursor: pointer;
}

.overlay ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  display: block;
}

.overlay li {
  margin-top: 24px;
  opacity: 0;
  transform: translateY(16px);
  transition:
    opacity 0.3s,
    transform 0.3s;
}

.overlay.show li {
  opacity: 1;
  transform: none;
}

.overlay.show li:nth-child(1) {
  transition-delay: 0.1s;
}

.overlay.show li:nth-child(2) {
  transition-delay: 0.2s;
}

.overlay.show li:nth-child(3) {
  transition-delay: 0.3s;
}

.pc-menu {
  display: none;
}

@media (min-width: 600px) {
  .pc-menu {
    display: block;
    margin-left: auto;
  }

  .pc-menu ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    display: flex;
  }

  .pc-menu a {
    display: block;
    width: 80px;
    text-align: center;
  }

  .pc-menu a:hover {
    background: #f2f2f2;
  }

  .sp-menu {
    display: none;
  }
}
</style>
