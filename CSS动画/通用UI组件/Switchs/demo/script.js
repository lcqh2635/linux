const checkboxes = document.querySelectorAll('input[type="checkbox"]');

const detectToggleOnce = (e) => {
  e.target.classList.add('toggled-once');
};

checkboxes.forEach(checkbox => {
  checkbox.addEventListener('click', detectToggleOnce, { once: true });
});