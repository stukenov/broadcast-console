import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["video", "progressBar", "duration"]

  connect() {
    this.video = this.element.querySelector(`#video-player`)
    this.playButton = this.element.querySelector(`#play-button`)
    this.pauseButton = this.element.querySelector(`#pause-button`)
    this.stopButton = this.element.querySelector(`#stop-button`)
    this.progressBar = this.element.querySelector(`#video-progress-bar`)
    this.duration = this.element.querySelector(`#video-duration`)

    this.video.addEventListener('timeupdate', this.updateProgress.bind(this))
    this.video.addEventListener('loadedmetadata', this.updateDuration.bind(this))
    this.video.addEventListener('ended', this.resetProgress.bind(this))
  }

  play() {
    if (this.video.paused || this.video.ended) {
      this.video.play()
    }
  }

  pause() {
    if (!this.video.paused && !this.video.ended) {
      this.video.pause()
    }
  }

  stop() {
    this.video.pause()
    this.video.currentTime = 0
    this.progressBar.style.width = '0%'
  }

  updateProgress() {
    if (this.video.duration) {
      const percentage = (this.video.currentTime / this.video.duration) * 100
      this.progressBar.style.width = `${percentage}%`
    }
  }

  updateDuration() {
    this.duration.textContent = `${this.video.duration.toFixed(2)} seconds`
  }

  resetProgress() {
    this.progressBar.style.width = '0%'
  }
}
