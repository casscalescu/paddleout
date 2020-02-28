import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Rent a surfboard", "Hit the waves"],
    typeSpeed: 40,
    loop: true
  });
}

export { loadDynamicBannerText };