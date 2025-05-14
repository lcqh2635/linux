/**
 * GSAP动画配置文件
 * 包含页面滚动动画、元素入场动画等
 */

// 等待DOM完全加载
document.addEventListener('DOMContentLoaded', function() {
    // 注册ScrollTrigger插件
    gsap.registerPlugin(ScrollTrigger);

    // 初始化所有动画
    initAnimations();
});

function initAnimations() {
    // 导航栏动画
    gsap.from('.navbar', {
        duration: 0.8,
        y: -100,
        opacity: 0,
        ease: 'power3.out'
    });

    // 英雄区域动画
    const heroTl = gsap.timeline();
    heroTl.from('.hero-title', {
        duration: 0.8,
        y: 50,
        opacity: 0,
        ease: 'power3.out'
    })
        .from('.hero-subtitle', {
            duration: 0.6,
            y: 30,
            opacity: 0,
            ease: 'power2.out'
        }, '-=0.4')
        .from('.hero-image', {
            duration: 0.8,
            x: 100,
            opacity: 0,
            ease: 'back.out(1.7)'
        }, '-=0.6')
        .from('.btn', {
            duration: 0.5,
            scale: 0,
            opacity: 0,
            ease: 'back.out(1.7)'
        }, '-=0.4');

    // 商品区域动画
    gsap.utils.toArray('.product-card').forEach((card, i) => {
        gsap.from(card, {
            scrollTrigger: {
                trigger: card,
                start: 'top 80%',
                toggleActions: 'play none none none'
            },
            duration: 0.8,
            y: 50,
            opacity: 0,
            delay: i * 0.1,
            ease: 'power2.out'
        });
    });

    // 特色区域动画
    gsap.utils.toArray('.feature').forEach((feature, i) => {
        gsap.from(feature, {
            scrollTrigger: {
                trigger: feature,
                start: 'top 80%',
                toggleActions: 'play none none none'
            },
            duration: 0.6,
            y: 50,
            opacity: 0,
            delay: i * 0.15,
            ease: 'power2.out'
        });
    });

    // 评价区域动画
    gsap.from('.testimonial-slide.active', {
        scrollTrigger: {
            trigger: '.testimonials',
            start: 'top 80%',
            toggleActions: 'play none none none'
        },
        duration: 0.8,
        y: 50,
        opacity: 0,
        ease: 'power2.out'
    });

    // 联系区域动画
    const contactTl = gsap.timeline({
        scrollTrigger: {
            trigger: '.contact',
            start: 'top 80%',
            toggleActions: 'play none none none'
        }
    });

    contactTl.from('.contact-info', {
        duration: 0.6,
        x: -50,
        opacity: 0,
        ease: 'power2.out'
    })
        .from('.contact-form', {
            duration: 0.6,
            x: 50,
            opacity: 0,
            ease: 'power2.out'
        }, '-=0.4');

    // 购物车侧边栏动画
    const cartSidebar = document.querySelector('.cart-sidebar');
    const cartOverlay = document.querySelector('.cart-overlay');

    // 打开购物车动画
    function openCartAnimation() {
        gsap.to(cartOverlay, {
            duration: 0.3,
            opacity: 1,
            visibility: 'visible',
            ease: 'power2.out'
        });

        gsap.to(cartSidebar, {
            duration: 0.5,
            x: 0,
            ease: 'back.out(1.7)'
        });
    }

    // 关闭购物车动画
    function closeCartAnimation() {
        gsap.to(cartSidebar, {
            duration: 0.3,
            x: 400,
            ease: 'power2.in'
        });

        gsap.to(cartOverlay, {
            duration: 0.3,
            opacity: 0,
            visibility: 'hidden',
            ease: 'power2.out',
            delay: 0.2
        });
    }

    // 通知动画
    function notificationAnimation(notification) {
        gsap.from(notification, {
            duration: 0.3,
            y: 20,
            opacity: 0,
            ease: 'power2.out'
        });
    }

    // 将动画函数暴露给全局，以便在main.js中调用
    window.animations = {
        openCartAnimation,
        closeCartAnimation,
        notificationAnimation
    };
}