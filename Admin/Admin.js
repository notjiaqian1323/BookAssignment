let arrow = document.querySelectorAll(".arrow");
console.log(arrow);
for (var i = 0; i < arrow.length; i++) {
    arrow[i].addEventListener("click", (e) => {
        let arrowParent = e.target.parentElement.parentElement;
        console.log(arrowParent);
        arrowParent.classList.toggle("showMenu");
    })
}

let sidebar = document.querySelector(".sidebar");
let sidebarbtn = document.querySelector(".bx-menu");
console.log(sidebarbtn);
sidebarbtn.addEventListener("click", () => {
    sidebar.classList.toggle("close");
});


// CHARTS

// BAR CHARTS
document.addEventListener("DOMContentLoaded", function () {
    fetch('DashboardRedesign.aspx/GetGenreOrderData', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        }
    })
        .then(response => response.json())
        .then(data => {
            // Ensure the categories array matches the genres
            const categories = ['Fantasy', 'Mystery', 'Romance', 'Science Fiction', 'Comedy'];
            console.log('Data from server:', data);
            console.log('Categories:', categories);

            // Parse the data from the 'd' property
            const rawData = JSON.parse(data.d);
            const orderCounts = categories.map(genre => rawData[genre] || 0);


            const barChartOptions = {
                series: [
                    {
                        data: orderCounts,
                        name: 'Products',
                    },
                ],
                chart: {
                    type: 'bar',
                    background: 'transparent',
                    height: 350,
                    toolbar: {
                        show: false,
                    },
                },
                colors: ['#2962ff', '#d50000', '#2e7d32', '#ff6d00', '#583cb3'],
                plotOptions: {
                    bar: {
                        distributed: true,
                        borderRadius: 4,
                        horizontal: false,
                        columnWidth: '40%',
                    },
                },
                dataLabels: {
                    enabled: false,
                },
                fill: {
                    opacity: 1,
                },
                grid: {
                    borderColor: '#55596e',
                    yaxis: {
                        lines: {
                            show: true,
                        },
                    },
                    xaxis: {
                        lines: {
                            show: true,
                        },
                    },
                },
                legend: {
                    labels: {
                        colors: '#f5f7ff',
                    },
                    show: true,
                    position: 'top',
                },
                stroke: {
                    colors: ['transparent'],
                    show: true,
                    width: 2,
                },
                tooltip: {
                    shared: true,
                    intersect: false,
                    theme: 'dark',
                },
                xaxis: {
                    categories: categories,
                    title: {
                        style: {
                            color: '#f5f7ff',
                        },
                    },
                    axisBorder: {
                        show: true,
                        color: '#55596e',
                    },
                    axisTicks: {
                        show: true,
                        color: '#55596e',
                    },
                    labels: {
                        style: {
                            colors: '#f5f7ff',
                        },
                    },
                },
                yaxis: {
                    title: {
                        text: 'Successful Orders',
                        style: {
                            color: '#f5f7ff',
                        },
                    },
                    axisBorder: {
                        color: '#55596e',
                        show: true,
                    },
                    axisTicks: {
                        color: '#55596e',
                        show: true,
                    },
                    labels: {
                        style: {
                            colors: '#f5f7ff',
                        },
                    },
                },
            };

            const barChart = new ApexCharts(
                document.querySelector('#bar-chart'),
                barChartOptions
            );
            barChart.render();
        })
        .catch(error => console.error('Error fetching genre data:', error));
});
