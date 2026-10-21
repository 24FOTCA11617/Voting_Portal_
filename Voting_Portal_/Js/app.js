// Client-side UI dynamics, view switching, modal handlers & receipts

document.addEventListener('DOMContentLoaded', function () {
    console.log("LokMat Engine Loaded.");

    // Auto-dismiss notification labels after 4 seconds
    const statusLabels = document.querySelectorAll('#lblMsg');
    statusLabels.forEach(label => {
        if (label.innerText.trim() !== '') {
            setTimeout(() => {
                label.style.display = 'none';
            }, 4000);
        }
    });
});

// Modal Handler for Ballots and Receipts
function showReceiptModal(epic, candidateName, timestamp) {
    alert("VOTE RECEIPT\n-----------------------\nEPIC: " + epic + "\nCandidate: " + candidateName + "\nTime: " + timestamp + "\nStatus: SECURED");
}