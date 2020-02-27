import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Rent a surfboard", "Hit the waves!"],
    typeSpeed: 50,
    loop: true
  });
}

export { loadDynamicBannerText };