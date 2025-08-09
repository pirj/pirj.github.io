import { createTimeline, animate, stagger } from 'https://cdn.jsdelivr.net/npm/animejs@4.1.2/+esm';

addEventListener('zero-md-rendered', function() {
  const shadow = document.getElementsByTagName('zero-md')[0].shadowRoot
  const green = shadow.querySelectorAll('.circle.green')
  const red = shadow.querySelectorAll('.circle.red')
  const imagePng = shadow.querySelector('#image-png')

  const http = animate(green, {
    loop: 1,
    duration: 500,
    alternate: true,
    x: '8rem',
    ease: 'out(0.5)',
  });

  let loops = 0
  const image = animate(red, {
    loop: 50,
    duration: 200,
    onBegin: () => { loops = 0 },
    onLoop: () => {
      imagePng.textContent = "image" + ++loops + '.png'
    },
    x: '8rem',
    ease: 'out(0.5)',
    delay: stagger([10, 20, 30]),
  });

  const timeline =
    createTimeline({ loop: true })
      .sync(http)
      .sync(image, 1000)
})
