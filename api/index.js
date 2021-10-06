const express = require("express");
const app = express();

app.use(express.json());

const topics = [
  {
    id: "1",
    name: "Work",
    color: "0xff5499C7",
  },
  {
    id: "2",
    name: "School",
    color: "0xffF1C40F",
  },
  {
    id: "3",
    name: "Home",
    color: "0xffE59866",
  },
];

app.listen(3000, () => console.log("start"));

app.get("/topics", (req, res) => {
  res.send({
    code: 200,
    data: topics,
  });
});

app.post("/topics", (req, res) => {
  const newTopic = {
    ...req.body,
    id: (topics.length + 1).toString(),
  };
  topics.push(newTopic);
  res.send({
    code: 200,
    data: newTopic,
  });
});
