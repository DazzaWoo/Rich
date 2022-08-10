import ax from "axios"

const metaToken = document.querySelector("meta[name=csrf-token")

if (metaToken) {
  const token = metaToken.textContent
  ax.defaults.headers.common["X-CSRF-TOKEN"] = token
}

export default ax