/**
 * 主JavaScript文件 - 商城功能实现
 * 包含商品展示、购物车功能、评价轮播等核心功能
 */

// 等待DOM完全加载
document.addEventListener('DOMContentLoaded', function() {
    // 初始化应用
    initApp();
});

function initApp() {
    // 初始化商品数据
    const products = [
        {
            id: 1,
            title: '无线蓝牙耳机',
            price: 299,
            image: 'images/product1.jpg',
            rating: 4,
            description: '高音质无线蓝牙耳机，持久续航'
        },
        {
            id: 2,
            title: '智能手表',
            price: 899,
            image: 'images/product2.jpg',
            rating: 5,
            description: '多功能智能手表，健康监测'
        },
        {
            id: 3,
            title: '便携充电宝',
            price: 159,
            image: 'images/product3.jpg',
            rating: 4,
            description: '10000mAh大容量，快速充电'
        },
        {
            id: 4,
            title: '机械键盘',
            price: 499,
            image: 'images/product4.jpg',
            rating: 5,
            description: 'RGB背光机械键盘，游戏办公'
        },
        {
            id: 5,
            title: '无线鼠标',
            price: 199,
            image: 'images/product5.jpg',
            rating: 4,
            description: '人体工学设计，精准定位'
        },
        {
            id: 6,
            title: '笔记本电脑',
            price: 5999,
            image: 'images/product6.jpg',
            rating: 5,
            description: '高性能轻薄本，办公娱乐'
        }
    ];

    // 初始化评价数据
    const testimonials = [
        {
            content: '商品质量非常好，物流也很快，客服态度也很棒，下次还会再来！',
            author: '张先生',
            role: '资深买家',
            image: 'images/user1.jpg'
        },
        {
            content: '第一次在这家店购物，体验超出预期，包装很精致，商品和描述完全一致。',
            author: '李女士',
            role: '新客户',
            image: 'images/user2.jpg'
        },
        {
            content: '已经是老顾客了，每次购物都很满意，价格合理，品质有保障。',
            author: '王先生',
            role: 'VIP会员',
            image: 'images/user3.jpg'
        }
    ];

    // 购物车数据
    let cart = JSON.parse(localStorage.getItem('cart')) || [];

    // DOM元素
    const productGrid = document.querySelector('.product-grid');
    const testimonialSlider = document.querySelector('.testimonial-slider');
    const cartIcon = document.querySelector('.cart-icon');
    const cartCount = document.querySelector('.cart-count');
    const cartSidebar = document.querySelector('.cart-sidebar');
    const closeCartBtn = document.querySelector('.close-cart');
    const cartOverlay = document.querySelector('.cart-overlay');
    const cartItemsContainer = document.querySelector('.cart-items');
    const totalPriceElement = document.querySelector('.total-price');
    const hamburger = document.querySelector('.hamburger');
    const navLinks = document.querySelector('.nav-links');
    const contactForm = document.querySelector('.contact-form');

    // 渲染商品列表
    function renderProducts() {
        productGrid.innerHTML = '';
        products.forEach(product => {
            const productCard = document.createElement('div');
            productCard.className = 'product-card';
            productCard.innerHTML = `
                <div class="product-image">
                    <img src="${product.image}" alt="${product.title}">
                </div>
                <div class="product-info">
                    <h3 class="product-title">${product.title}</h3>
                    <div class="product-price">¥${product.price.toFixed(2)}</div>
                    <div class="product-rating">
                        ${'★'.repeat(product.rating)}${'☆'.repeat(5 - product.rating)}
                    </div>
                    <button class="add-to-cart" data-id="${product.id}">加入购物车</button>
                </div>
            `;
            productGrid.appendChild(productCard);
        });

        // 添加购物车按钮事件
        document.querySelectorAll('.add-to-cart').forEach(button => {
            button.addEventListener('click', addToCart);
        });
    }

    // 渲染评价轮播
    function renderTestimonials() {
        testimonialSlider.innerHTML = '';

        // 创建评价内容容器
        const slidesContainer = document.createElement('div');
        slidesContainer.className = 'slides-container';

        // 创建评价导航
        const testimonialNav = document.createElement('div');
        testimonialNav.className = 'testimonial-nav';

        // 添加评价内容
        testimonials.forEach((testimonial, index) => {
            const slide = document.createElement('div');
            slide.className = `testimonial-slide ${index === 0 ? 'active' : ''}`;
            slide.innerHTML = `
                <div class="testimonial-content">
                    <p>"${testimonial.content}"</p>
                </div>
                <div class="testimonial-author">
                    <div class="author-image">
                        <img src="${testimonial.image}" alt="${testimonial.author}">
                    </div>
                    <div class="author-info">
                        <h4>${testimonial.author}</h4>
                        <p>${testimonial.role}</p>
                    </div>
                </div>
            `;
            slidesContainer.appendChild(slide);

            // 添加导航点
            const navDot = document.createElement('button');
            navDot.className = `nav-dot ${index === 0 ? 'active' : ''}`;
            navDot.dataset.index = index;
            testimonialNav.appendChild(navDot);
        });

        testimonialSlider.appendChild(slidesContainer);
        testimonialSlider.appendChild(testimonialNav);

        // 添加导航点点击事件
        document.querySelectorAll('.nav-dot').forEach(dot => {
            dot.addEventListener('click', function() {
                const index = parseInt(this.dataset.index);
                showTestimonial(index);
            });
        });

        // 自动轮播
        let currentIndex = 0;
        setInterval(() => {
            currentIndex = (currentIndex + 1) % testimonials.length;
            showTestimonial(currentIndex);
        }, 5000);
    }

    // 显示指定索引的评价
    function showTestimonial(index) {
        const slides = document.querySelectorAll('.testimonial-slide');
        const dots = document.querySelectorAll('.nav-dot');

        slides.forEach(slide => slide.classList.remove('active'));
        dots.forEach(dot => dot.classList.remove('active'));

        slides[index].classList.add('active');
        dots[index].classList.add('active');
    }

    // 添加商品到购物车
    function addToCart(e) {
        const productId = parseInt(e.target.dataset.id);
        const product = products.find(p => p.id === productId);

        // 检查购物车是否已有该商品
        const existingItem = cart.find(item => item.id === productId);

        if (existingItem) {
            existingItem.quantity += 1;
        } else {
            cart.push({
                ...product,
                quantity: 1
            });
        }

        // 更新本地存储
        localStorage.setItem('cart', JSON.stringify(cart));

        // 更新购物车图标数量
        updateCartCount();

        // 显示添加成功反馈
        showNotification(`${product.title} 已添加到购物车`);
    }

    // 更新购物车数量显示
    function updateCartCount() {
        const totalItems = cart.reduce((total, item) => total + item.quantity, 0);
        cartCount.textContent = totalItems;
    }

    // 渲染购物车内容
    function renderCart() {
        cartItemsContainer.innerHTML = '';

        if (cart.length === 0) {
            cartItemsContainer.innerHTML = '<p class="empty-cart">购物车是空的</p>';
            totalPriceElement.textContent = '¥0.00';
            return;
        }

        let totalPrice = 0;

        cart.forEach(item => {
            const cartItem = document.createElement('div');
            cartItem.className = 'cart-item';
            cartItem.innerHTML = `
                <div class="cart-item-image">
                    <img src="${item.image}" alt="${item.title}">
                </div>
                <div class="cart-item-info">
                    <h4 class="cart-item-title">${item.title}</h4>
                    <div class="cart-item-price">¥${item.price.toFixed(2)}</div>
                    <div class="cart-item-quantity">
                        <button class="quantity-btn decrease" data-id="${item.id}">-</button>
                        <span class="quantity">${item.quantity}</span>
                        <button class="quantity-btn increase" data-id="${item.id}">+</button>
                    </div>
                    <button class="remove-item" data-id="${item.id}">移除</button>
                </div>
            `;
            cartItemsContainer.appendChild(cartItem);

            totalPrice += item.price * item.quantity;
        });

        totalPriceElement.textContent = `¥${totalPrice.toFixed(2)}`;

        // 添加数量按钮事件
        document.querySelectorAll('.decrease').forEach(btn => {
            btn.addEventListener('click', decreaseQuantity);
        });

        document.querySelectorAll('.increase').forEach(btn => {
            btn.addEventListener('click', increaseQuantity);
        });

        document.querySelectorAll('.remove-item').forEach(btn => {
            btn.addEventListener('click', removeItem);
        });
    }

    // 减少商品数量
    function decreaseQuantity(e) {
        const productId = parseInt(e.target.dataset.id);
        const itemIndex = cart.findIndex(item => item.id === productId);

        if (cart[itemIndex].quantity > 1) {
            cart[itemIndex].quantity -= 1;
        } else {
            cart.splice(itemIndex, 1);
        }

        localStorage.setItem('cart', JSON.stringify(cart));
        updateCartCount();
        renderCart();
    }

    // 增加商品数量
    function increaseQuantity(e) {
        const productId = parseInt(e.target.dataset.id);
        const item = cart.find(item => item.id === productId);

        item.quantity += 1;

        localStorage.setItem('cart', JSON.stringify(cart));
        updateCartCount();
        renderCart();
    }

    // 移除商品
    function removeItem(e) {
        const productId = parseInt(e.target.dataset.id);
        const itemIndex = cart.findIndex(item => item.id === productId);

        cart.splice(itemIndex, 1);

        localStorage.setItem('cart', JSON.stringify(cart));
        updateCartCount();
        renderCart();
    }

    // 显示通知
    function showNotification(message) {
        const notification = document.createElement('div');
        notification.className = 'notification';
        notification.textContent = message;
        document.body.appendChild(notification);

        // 显示动画
        setTimeout(() => {
            notification.classList.add('show');
        }, 10);

        // 隐藏动画
        setTimeout(() => {
            notification.classList.remove('show');
            setTimeout(() => {
                notification.remove();
            }, 300);
        }, 3000);
    }

    // 处理联系表单提交
    function handleContactFormSubmit(e) {
        e.preventDefault();

        const formData = new FormData(contactForm);
        const data = Object.fromEntries(formData);

        // 这里应该是发送到服务器的代码
        console.log('表单提交:', data);

        // 显示成功消息
        showNotification('您的消息已发送，我们会尽快回复您！');

        // 重置表单
        contactForm.reset();
    }

    // 初始化事件监听
    function initEventListeners() {
        // 购物车图标点击
        cartIcon.addEventListener('click', () => {
            cartSidebar.classList.add('active');
            cartOverlay.classList.add('active');
            renderCart();
        });

        // 关闭购物车
        closeCartBtn.addEventListener('click', () => {
            cartSidebar.classList.remove('active');
            cartOverlay.classList.remove('active');
        });

        // 购物车遮罩层点击
        cartOverlay.addEventListener('click', () => {
            cartSidebar.classList.remove('active');
            cartOverlay.classList.remove('active');
        });

        // 汉堡菜单点击
        hamburger.addEventListener('click', () => {
            hamburger.classList.toggle('active');
            navLinks.classList.toggle('active');
        });

        // 导航链接点击
        document.querySelectorAll('.nav-links a').forEach(link => {
            link.addEventListener('click', () => {
                // 如果是移动端视图，点击后关闭菜单
                if (window.innerWidth <= 768) {
                    hamburger.classList.remove('active');
                    navLinks.classList.remove('active');
                }
            });
        });

        // 联系表单提交
        contactForm.addEventListener('submit', handleContactFormSubmit);

        // 滚动时改变导航栏样式
        window.addEventListener('scroll', () => {
            if (window.scrollY > 50) {
                document.querySelector('.navbar').classList.add('scrolled');
            } else {
                document.querySelector('.navbar').classList.remove('scrolled');
            }
        });
    }

    // 初始化页面加载动画
    function initPreloader() {
        const preloader = document.querySelector('.preloader');

        // 模拟加载时间
        setTimeout(() => {
            preloader.style.opacity = '0';
            setTimeout(() => {
                preloader.style.display = 'none';
            }, 500);
        }, 1500);
    }

    // 初始化所有功能
    renderProducts();
    renderTestimonials();
    updateCartCount();
    initEventListeners();
    initPreloader();
}