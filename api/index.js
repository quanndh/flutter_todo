const app = require("express")();

const topics = [
  {
    id: "1",
    name: "Work",
  },
  {
    id: "2",
    name: "School",
  },
  {
    id: "3",
    name: "Home",
  },
];

app.listen(3000, () => console.log("start"));

app.get("/topics", (req, res) => {
  res.send(topics);
});
