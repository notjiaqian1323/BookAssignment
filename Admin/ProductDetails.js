// Tracks edited fields
let editedFields = {};

// Toggle between Label and Textbox
function toggleEdit(labelId) {
    const label = document.getElementById(labelId);
    const parent = label.parentElement;
    const isEditing = label.tagName === 'INPUT';

    if (!isEditing) {
        // Switch to Input Box
        const value = label.innerText;
        const input = document.createElement('input');
        input.type = 'text';
        input.value = value;
        input.id = labelId;
        input.className = 'edit-input';
        parent.replaceChild(input, label);

        // Change Edit Icon to Save Icon
        parent.querySelector('.edit-icon').className = 'bx bx-check-double edit-icon';

        // Track Edited Field
        editedFields[labelId] = value;

        // Show Save Button
        document.getElementById('btnSaveChanges').style.display = 'block';
    } else {
        // Switch back to Label
        const input = document.getElementById(labelId);
        const value = input.value;
        const span = document.createElement('span');
        span.id = labelId;
        span.innerText = value;
        parent.replaceChild(span, input);

        // Change Save Icon back to Edit Icon
        parent.querySelector('.edit-icon').className = 'bx bxs-edit edit-icon';
    }
}

// Handle Image Upload
document.getElementById('btnEditImage').addEventListener('click', () => {
    document.getElementById('fileUploadImage').click();
});

document.getElementById('fileUploadImage').addEventListener('change', (event) => {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('imgBook').src = e.target.result;
            editedFields['Image'] = file;
            document.getElementById('btnSaveChanges').style.display = 'block';
        };
        reader.readAsDataURL(file);
    }
});

// Save Changes
function saveChanges() {
    const formData = new FormData();

    // Collect edited text fields
    for (const field in editedFields) {
        if (field === 'Image') {
            formData.append('Image', editedFields[field]);
        } else {
            formData.append(field, document.getElementById(field).innerText || document.getElementById(field).value);
        }
    }

    // Send data to server
    fetch('ProductDetails.aspx/SaveChanges', {
        method: 'POST',
        body: formData
    })
        .then(response => response.text())
        .then(data => {
            alert('Changes saved successfully!');
        })
        .catch(error => {
            console.error('Error:', error);
        });
}
