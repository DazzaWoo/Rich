import { Controller } from "stimulus"
// 安裝完 axios 後 import axios
// import axios from "axios"
// 改為 import 共用元件（axios 抓到 token）再傳進來
// import ax from "/app/javascript/lib/http/client"
// 用 rails/ujs 取代 axios
import Rails from "@rails/ujs"


export default class extends Controller {
  static targets = [ "likeButton" ]

  connect() {
    // this.outputTarget.textContent = 'Hello, Stimulus!'
    // console.log(123);
    // console.log("Hello Stimulus JS");
    if (this.element.dataset.liked === "true") {
      console.log('黑');
      this.likeButtonTarget.textContent = "liked"
    } else {
      console.log('白');
      this.likeButtonTarget.textContent = "disliked"
    }
  }
  setLiked(flag) {
    this.likeButtonTarget.textContent = flag ? "liked" : "disliked"
  }
  like_article() {
    // 拿 token
    // const token = document.querySelector("meta[name=csrf-token]").content
    // console.log(token);

    // 打 API -> POST /api/vi/articles/6/like
    // fetch 不支援 IE11
    // 選擇 axios 因為相容性高
    // axios.defaults.headers.common["X-CSRF-TOKEN"] = token
    // 以上放入共用元件 javascript/lib/http/client.js

    // stimulus js 提供 this.element: 找出 id 
    const articleID = this.element.dataset.articleID
    console.log(articleID)

    // console.log(axios);
    // ax.post(`/api/v1/articles/${clientID}/like`)
    //   .then(resp => {
    //     console.log(resp.data);
    //   })

    Rails.ajax({
      url: `/api/v1/articles/${articleID}/like`,
      type: 'post',
      // success: (resp) => {
      success: ({ state }) => {
        console.log(state);
        // if (state === 'liked') {
        //   this.likeButtonTarget.textContent = "liked"
        // } else {
        //   this.likeButtonTarget.textContent = "unlike"
        // }
        
        // const {state} = resp
      },
      error: (err) => {
        console.log('error');
      }
    })     
  }
}
